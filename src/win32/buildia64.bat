
rc readtemp.rc

cl -DNDEBUG -c -DCRTAPI1=_cdecl -DCRTAPI2=_cdecl -nologo^
 -GS -D_IA64_=1 -DWIN64 -D_WIN64  -DWIN32 -D_WIN32^
 -Wp64 -W4 -D_WINNT -D_WIN32_WINNT=0x0502^
 -DWINVER=0x0502  -D_MT -MT /Foreadtempia64.obj readtemp.c 


link /RELEASE /INCREMENTAL:NO /NOLOGO -subsystem:windows,5.02^
 -out:readtempia64.exe readtempia64.obj readtemp.res user32.lib^
 shell32.lib advapi32.lib gdi32.lib bufferoverflowu.lib
