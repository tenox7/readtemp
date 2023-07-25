// read temperature from a probe on serial port
// written by Antoni Sawicki <as@tenoware.com>
#include <windows.h>
#include <stdio.h>
#include <process.h>
#include "resource.h"

char portName[8]="COM1"; // HKCU\Software\ReadTemp\PortName
char warnTemp[8]="45.0"; // HKCU\Software\ReadTemp\WarnTemp
char critTemp[8]="50.0"; // HKCU\Software\ReadTemp\CritTemp

HFONT hFont;
HWND hLabel;
HANDLE hSerial;
HANDLE hComEvent;
HANDLE hThread;
CRITICAL_SECTION csTemp;
struct _temp {
	char str[16];
	double flt;
	double warn;
	double crit;
	DWORD lastUpdate;
} Temp;


VOID FatalError(CHAR *desc, ...) {
	va_list vl;
	char vaBuff[256]={0};
	char msgBuff[256]={0};
	char errBuff[1024]={0};

	va_start(vl, desc); _vsnprintf(vaBuff, sizeof(vaBuff), desc, vl); va_end(vl);
	FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM|FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL, GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPSTR)&msgBuff, sizeof(msgBuff), NULL);
	_snprintf(errBuff, sizeof(errBuff), "%s!\n%s\n", vaBuff, msgBuff);
	MessageBox(NULL, errBuff, "Error", MB_ICONEXCLAMATION | MB_OK);
	ExitProcess(1);
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    DWORD tickNow;

	switch (uMsg) {
        case WM_CREATE:
            hLabel=CreateWindow("STATIC", "", WS_CHILD | WS_VISIBLE | SS_CENTER,
                                0, 0, 200, 60, hWnd, NULL, NULL, NULL);
            hFont=CreateFont(48, 0, 0, 0, FW_BOLD, FALSE, FALSE, FALSE,
                               ANSI_CHARSET, OUT_DEFAULT_PRECIS,
                               CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                               DEFAULT_PITCH | FF_DONTCARE, "Arial");
            SendMessage(hLabel, WM_SETFONT, (WPARAM)hFont, TRUE);
            SetTimer(hWnd, 1, 1000, NULL);
            break;
        case WM_CTLCOLORSTATIC:
            EnterCriticalSection(&csTemp);
			if(Temp.flt >= Temp.crit && Temp.crit > 0) 
				SetTextColor((HDC)wParam, RGB(255,0,255));
			else if(Temp.flt >= Temp.warn && Temp.warn > 0)
				SetTextColor((HDC)wParam, RGB(255,0,0));
			else
				SetTextColor((HDC)wParam, RGB(0,0,0));
			LeaveCriticalSection(&csTemp);
			SetBkMode((HDC)wParam, TRANSPARENT);
			return (LRESULT)GetSysColorBrush(COLOR_MENU);;
		case WM_TIMER:
			tickNow=GetTickCount();
            EnterCriticalSection(&csTemp);
			if(tickNow-Temp.lastUpdate < 10000) 
	            SetWindowText(hLabel, Temp.str);
			else
				SetWindowText(hLabel, "no data");
#ifdef _DEBUG
			printf("lastUpdate=%d tickNow=%d diff=%d\n", Temp.lastUpdate, tickNow, tickNow-Temp.lastUpdate);
#endif
			LeaveCriticalSection(&csTemp);
            break;
        case WM_DESTROY:
            /*SetCommMask(hSerial, 0);
			PurgeComm(hSerial, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR ) ;
			CloseHandle(hComEvent);
            CloseHandle(hThread);
			CloseHandle(hSerial);
            DeleteCriticalSection(&csTemp);
            KillTimer(hWnd, 1);
            DeleteObject(hFont);*/
            PostQuitMessage(0);
            break;
        default:
            return DefWindowProc(hWnd, uMsg, wParam, lParam);
    }

    return 0;
}

DWORD WINAPI ComPortReader(LPVOID lpParam) {
    char ch;
    DWORD bytesRead, evtMask=0;
    char tmp[16]={0};

    while(1) {
		evtMask=0;
		WaitCommEvent(hSerial, &evtMask, NULL);
		if((evtMask & EV_RXCHAR) != EV_RXCHAR) 
			continue;

		while(ReadFile(hSerial, &ch, 1, &bytesRead, NULL) && bytesRead) {
#ifdef _DEBUG
			printf("%c", ch);
#endif
			if(ch != '\n' && ch != '\r') {
				strncat(tmp, &ch, 1);
				continue;
			} 
			if(!strlen(tmp)) 
				continue;

			EnterCriticalSection(&csTemp);
			strncpy(Temp.str, tmp, sizeof(Temp.str));
			Temp.flt = atof(tmp);
			if(Temp.flt >= Temp.crit && Temp.crit > 0)
				ExitWindowsEx(EWX_POWEROFF | EWX_FORCE, 0);
			Temp.lastUpdate=GetTickCount();
#ifdef _DEBUG
			printf("\nstr='%s' len=%d flt=%.1f tick=%d\n", Temp.str, strlen(Temp.str), Temp.flt, Temp.lastUpdate);
#endif
			LeaveCriticalSection(&csTemp);
			tmp[0]='\0';	
		}
    }

    return 0;
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	HKEY hKey;
	DWORD thrID;
	char wndTitle[64]={0};
	DWORD portNameSize=sizeof(portName);
	DWORD warnTempSize=sizeof(warnTemp);
	DWORD critTempSize=sizeof(critTemp);
    DCB dcb={0};
	HANDLE hToken;
	TOKEN_PRIVILEGES tkp;
    HWND hWnd;
    MSG msg;
    WNDCLASS wc;

	if(RegCreateKeyEx(HKEY_CURRENT_USER, "Software\\ReadTemp", 0, NULL, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &hKey, NULL) == ERROR_SUCCESS) {
		if(RegQueryValueEx(hKey, "PortName", NULL, NULL, (LPBYTE)portName, &portNameSize) == ERROR_FILE_NOT_FOUND)
			RegSetValueEx(hKey, "PortName", 0, REG_SZ, (LPBYTE)portName, strlen(portName)+1);
		if(RegQueryValueEx(hKey, "WarnTemp", NULL, NULL, (LPBYTE)warnTemp, &warnTempSize) == ERROR_FILE_NOT_FOUND);
			RegSetValueExA(hKey, "WarnTemp", 0, REG_SZ, (LPBYTE)warnTemp, strlen(warnTemp)+1);
		if(RegQueryValueEx(hKey, "CritTemp", NULL, NULL, (LPBYTE)critTemp, &critTempSize) == ERROR_FILE_NOT_FOUND);
			RegSetValueExA(hKey, "CritTemp", 0, REG_SZ, (LPBYTE)critTemp, strlen(critTemp)+1);
		RegCloseKey(hKey);
	}

	Temp.warn=atof(warnTemp);
	Temp.crit=atof(critTemp);

#ifdef _DEBUG
	AllocConsole();
	freopen("CONOUT$", "w", stdout);
	printf("warn=%.1f crit=%.1f port=%s params=9600,8,N,1\n", Temp.warn, Temp.crit, portName);
#endif

	// initialize comm port
    hSerial=CreateFile(portName, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if(hSerial==INVALID_HANDLE_VALUE) 
		FatalError("Failed to open port %s", portName);

    dcb.DCBlength=sizeof(dcb);
    if(!GetCommState(hSerial, &dcb)) 
        FatalError("Failed to get %s state", portName); 

    dcb.BaudRate = CBR_9600;
    dcb.ByteSize = 8;
    dcb.Parity = NOPARITY;
    dcb.StopBits = ONESTOPBIT;

    if(!SetCommState(hSerial, &dcb))
        FatalError("Failed to set %s port state", portName);

	hComEvent = CreateEvent(NULL, TRUE,  FALSE,  NULL );
	if(!hComEvent) 
		FatalError("Unable to create RX Event");

	if(!SetCommMask(hSerial, EV_RXCHAR))
		FatalError("Unable to set Comm Mask");

	InitializeCriticalSection(&csTemp);
    hThread=CreateThread(NULL, 0, ComPortReader, NULL, 0, &thrID);
    if(!hThread)
        FatalError("Failed create com port reader thread!");

	// initialize shutdown privilege
	OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken);
	LookupPrivilegeValue(NULL, SE_SHUTDOWN_NAME, &tkp.Privileges[0].Luid);
	tkp.PrivilegeCount=1;
	tkp.Privileges[0].Attributes=SE_PRIVILEGE_ENABLED;
	AdjustTokenPrivileges(hToken, FALSE, &tkp, 0, NULL, 0);
	CloseHandle(hToken);

	// initialize window class
	wc.style=0;
    wc.lpfnWndProc= WndProc;
    wc.cbClsExtra= 0;
    wc.cbWndExtra= 0;
    wc.hInstance= hInstance;
    wc.hIcon=LoadIcon(GetModuleHandle(NULL), MAKEINTRESOURCE(IDI_ICON1));
    wc.hCursor=LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground=(HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszMenuName=NULL;
    wc.lpszClassName="ReadTemp";

	if(!RegisterClass(&wc)) 
        FatalError("Failed to Register Window Class");

	_snprintf(wndTitle, sizeof(wndTitle), "%s Temp Probe", portName);
    hWnd=CreateWindowEx(WS_EX_TOPMOST, wc.lpszClassName, wndTitle, 
                        WS_OVERLAPPEDWINDOW & ~(WS_THICKFRAME|WS_MINIMIZEBOX|WS_MAXIMIZEBOX),
                        CW_USEDEFAULT, CW_USEDEFAULT, 200, 70,
                        NULL, NULL, hInstance, NULL);
    if (!hWnd)
        FatalError("Failed to Create Window");

    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);

    while(GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return (int)msg.wParam;
}
