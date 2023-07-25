@REM make sure to run SetWin64.bat first

rc readtemp.rc

cl -c -DCRTAPI1=_cdecl -DCRTAPI2=_cdecl -nologo -D_AXP64_=1 -D_ALPHA64_=1^
 -DALPHA=1 -DWIN64 -D_WIN64 -DWIN32 -D_WIN32 -Wp64 -W4 -Ap64 -D_WINNT^
 -D_WIN32_WINNT=0x0400 -D_WIN32_IE=0x0400 -DWINVER=0x0400 -D_MT -MT^
 /Foreadtempaxp64.obj readtemp.c 

link /INCREMENTAL:NO /NOLOGO -subsystem:windows,4.10 -out:readtempaxp64.exe^
 readtempaxp64.obj readtemp.res user32.lib shell32.lib advapi32.lib gdi32.lib
