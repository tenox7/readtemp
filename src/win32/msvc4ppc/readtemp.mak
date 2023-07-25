# Microsoft Developer Studio Generated NMAKE File, Format Version 41001
# ** DO NOT EDIT **

# TARGTYPE "Win32 (PPC) Application" 0x0701

!IF "$(CFG)" == ""
CFG=readtemp - Win32 (PPC) Debug
!MESSAGE No configuration specified.  Defaulting to readtemp - Win32 (PPC)\
 Debug.
!ENDIF 

!IF "$(CFG)" != "readtemp - Win32 (PPC) Release" && "$(CFG)" !=\
 "readtemp - Win32 (PPC) Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "readtemp.mak" CFG="readtemp - Win32 (PPC) Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "readtemp - Win32 (PPC) Release" (based on "Win32 (PPC) Application")
!MESSAGE "readtemp - Win32 (PPC) Debug" (based on "Win32 (PPC) Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
CPP=cl.exe
RSC=rc.exe
MTL=mktyplib.exe

!IF  "$(CFG)" == "readtemp - Win32 (PPC) Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "PPCRel"
# PROP BASE Intermediate_Dir "PPCRel"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "PPCRel"
# PROP Intermediate_Dir "PPCRel"
# PROP Target_Dir ""
OUTDIR=.\PPCRel
INTDIR=.\PPCRel

ALL : ".\PPCRel\readtemp.exe"

CLEAN : 
	-@erase ".\PPCRel\readtemp.exe"
	-@erase ".\PPCRel\readtemp.obj"
	-@erase ".\PPCRel\readtemp.res"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE MTL /nologo /D "NDEBUG" /PPC32
# ADD MTL /nologo /D "NDEBUG" /PPC32
MTL_PROJ=/nologo /D "NDEBUG" /PPC32 
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/readtemp.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\PPCRel/
CPP_SBRS=.\.
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
RSC_PROJ=/l 0x409 /fo"$(INTDIR)/readtemp.res" /d "NDEBUG" 
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/readtemp.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:PPC
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:PPC
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:windows /pdb:"$(OUTDIR)/readtemp.pdb"\
 /machine:PPC /out:"$(OUTDIR)/readtemp.exe" 
LINK32_OBJS= \
	".\PPCRel\readtemp.obj" \
	".\PPCRel\readtemp.res"

".\PPCRel\readtemp.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "readtemp - Win32 (PPC) Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "PPCDbg"
# PROP BASE Intermediate_Dir "PPCDbg"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "PPCDbg"
# PROP Intermediate_Dir "PPCDbg"
# PROP Target_Dir ""
OUTDIR=.\PPCDbg
INTDIR=.\PPCDbg

ALL : ".\PPCDbg\readtemp.exe"

CLEAN : 
	-@erase ".\PPCDbg\readtemp.exe"
	-@erase ".\PPCDbg\readtemp.obj"
	-@erase ".\PPCDbg\readtemp.pdb"
	-@erase ".\PPCDbg\readtemp.res"
	-@erase ".\PPCDbg\vc40.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE MTL /nologo /D "_DEBUG" /PPC32
# ADD MTL /nologo /D "_DEBUG" /PPC32
MTL_PROJ=/nologo /D "_DEBUG" /PPC32 
# ADD BASE CPP /nologo /W3 /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /W3 /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
CPP_PROJ=/nologo /MLd /W3 /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/readtemp.pch" /YX /Fo"$(INTDIR)/" /Fd"$(INTDIR)/" /c 
CPP_OBJS=.\PPCDbg/
CPP_SBRS=.\.
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
RSC_PROJ=/l 0x409 /fo"$(INTDIR)/readtemp.res" /d "_DEBUG" 
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/readtemp.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:PPC
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:PPC
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:windows /pdb:"$(OUTDIR)/readtemp.pdb" /debug\
 /machine:PPC /out:"$(OUTDIR)/readtemp.exe" 
LINK32_OBJS= \
	".\PPCDbg\readtemp.obj" \
	".\PPCDbg\readtemp.res"

".\PPCDbg\readtemp.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "readtemp - Win32 (PPC) Release"
# Name "readtemp - Win32 (PPC) Debug"

!IF  "$(CFG)" == "readtemp - Win32 (PPC) Release"

!ELSEIF  "$(CFG)" == "readtemp - Win32 (PPC) Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=\readtemp\win32\resource.h

!IF  "$(CFG)" == "readtemp - Win32 (PPC) Release"

!ELSEIF  "$(CFG)" == "readtemp - Win32 (PPC) Debug"

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=\readtemp\win32\readtemp.rc
DEP_RSC_READT=\
	"..\readtemp.ico"\
	

!IF  "$(CFG)" == "readtemp - Win32 (PPC) Release"


".\PPCRel\readtemp.res" : $(SOURCE) $(DEP_RSC_READT) "$(INTDIR)"
   $(RSC) /l 0x409 /fo"$(INTDIR)/readtemp.res" /i "\readtemp\win32" /d "NDEBUG"\
 $(SOURCE)


!ELSEIF  "$(CFG)" == "readtemp - Win32 (PPC) Debug"


".\PPCDbg\readtemp.res" : $(SOURCE) $(DEP_RSC_READT) "$(INTDIR)"
   $(RSC) /l 0x409 /fo"$(INTDIR)/readtemp.res" /i "\readtemp\win32" /d "_DEBUG"\
 $(SOURCE)


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=\readtemp\win32\readtemp.c

!IF  "$(CFG)" == "readtemp - Win32 (PPC) Release"


".\PPCRel\readtemp.obj" : $(SOURCE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "readtemp - Win32 (PPC) Debug"


".\PPCDbg\readtemp.obj" : $(SOURCE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

# End Source File
# End Target
# End Project
################################################################################
