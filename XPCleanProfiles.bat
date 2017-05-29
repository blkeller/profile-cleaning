@ECHO OFF
ECHO.
ECHO. ***********************************************
ECHO. Profile Clean Utility for Medill School
ECHO. Written by Brett Keller
ECHO. Based on original work by Mike Stone from
ECHO. http://mstoneblog.wordpress.com/2010/12/08/
ECHO. ***********************************************
ECHO.

VER | FIND "5.1.2600" > NUL
IF NOT %ERRORLEVEL% == 0 GOTO :WRONGOS

ECHO %USERNAME% | FIND "hansel" > NUL
IF %ERRORLEVEL% == 0 GOTO :HANSEL

MKDIR %SYSTEMROOT%\SYSTEM32\drivers\xyzzyTEMP > NUL
IF NOT %ERRORLEVEL% == 0 GOTO :NOTADMIN
RMDIR /S /Q %SYSTEMROOT%\SYSTEM32\drivers\xyzzyTEMP > NUL

FOR /f "tokens=*" %%a IN ('dir "c:\Documents and Settings\" /b /ad') DO CALL :PATHCHECK "%%a"
GOTO REGISTRY

:PATHCHECK
IF /i [%1]==["%USERNAME%"] GOTO :PATHSKIPCURRENT
IF /i [%1]==["Administrator"] GOTO :PATHSKIP
IF /i [%1]==["hansel"] GOTO :PATHSKIP
IF /i [%1]==["Default"] GOTO :PATHSKIP
IF /i [%1]==["Default user"] GOTO :PATHSKIP
IF /i [%1]==["public"] GOTO :PATHSKIP
IF /i [%1]==["All Users"] GOTO :PATHSKIP
IF /i [%1]==["LocalService"] GOTO :PATHSKIP
IF /i [%1]==["NetworkService"] GOTO :PATHSKIP
IF /i [%1]==["DellOpenManage.medill"] GOTO :PATHSKIP
IF /i [%1]==["DellOpenManage"] GOTO :PATHSKIP
:: Enter any other profiles here by copying and pasting any of the above and changing the name.
GOTO PATHCLEAN

:PATHSKIP
ECHO. Skipping path clean for user %1
GOTO :EOF

:PATHSKIPCURRENT
ECHO. Skipping path clean for CURRENT USER %1
GOTO :EOF

:PATHCLEAN
ECHO. Cleaning profile for: %1
rmdir "C:\Documents and Settings\%1" /s /q > NUL
IF EXIST "C:\Documents and Settings\%1" GOTO RETRYPATHFIRST
IF NOT EXIST "C:\Documents and Settings\%1" GOTO :EOF

:RETRYPATHFIRST
ECHO. Error cleaning profile for: %1 - Trying again.
rmdir "C:\Documents and Settings\%1" /s /q > NUL
IF EXIST "C:\Documents and Settings\%1" GOTO RETRYPATHSECOND
IF NOT EXIST "C:\Documents and Settings\%1" GOTO :EOF

:RETRYPATHSECOND
ECHO. Error cleaning profile for: %1 - Trying again.
rmdir "C:\Documents and Settings\%1" /s /q > NUL
IF EXIST "C:\Documents and Settings\%1" ECHO. ** Unable to clean profile for: %1 - PLEASE MANUALLY REMOVE DIRECTORY!
GOTO :EOF

:REGISTRY
ECHO.------------
FOR /f "tokens=*" %%a IN ('reg query "hklm\software\microsoft\windows nt\currentversion\profilelist"^|find /i "s-1-5-21"') DO CALL :REGCHECK "%%a"
GOTO EXIT

:REGCHECK
FOR /f "tokens=5" %%b in ('reg query %1 /v ProfileImagePath') DO SET USERREG=%%b
IF /i [%USERREG%]==[Settings\%USERNAME%] GOTO :REGSKIPCURRENT
IF /i [%USERREG%]==[Settings\Administrator] GOTO :REGSKIP
IF /i [%USERREG%]==[Settings\hansel] GOTO :REGSKIP
IF /i [%USERREG%]==[Settings\DellOpenManage.medill] GOTO :REGSKIP
IF /i [%USERREG%]==[Settings\DellOpenManage] GOTO :REGSKIP
:: Enter any other profiles here by copying and pasting any of the above and changing the name.
GOTO REGCLEAN

:REGSKIP
ECHO. Skipping registry clean for %USERREG%
GOTO :EOF

:REGSKIPCURRENT
ECHO. Skipping registry clean for CURRENT USER %USERREG%
GOTO :EOF

:REGCLEAN
ECHO. Cleaning registry for: %USERREG%
reg delete %1 /f > NUL
GOTO :EOF

:EXIT
REM CLS
ECHO.
ECHO. ***********************************************
ECHO. Profile Clean Utility for Medill School
ECHO. Written by Brett Keller
ECHO. Based on original work by Mike Stone from
ECHO. http://mstoneblog.wordpress.com/2010/12/08/
ECHO. ***********************************************
ECHO.
ECHO. Profile cleaning is complete.
ECHO.
PAUSE
EXIT

:WRONGOS
ECHO. The script has detected that you are NOT running Windows XP!
ECHO. Please execute the appropriate script for the OS you are running.
ECHO.
ECHO. TERMINATING SCRIPT
ECHO.
PAUSE
EXIT

:HANSEL
ECHO. It appears that you are logged in to the "hansel" account.
ECHO. This script will not run properly when executed as this user.
ECHO. Please run it under a domain administrator's user account.
ECHO.
ECHO. TERMINATING SCRIPT
ECHO.
PAUSE
EXIT

:NOTADMIN
ECHO.
ECHO. The script is unable to establish elevated privileges.
ECHO. Please check and make sure that you are logged into an
ECHO. administrator's account and that User Account Control
ECHO. is either turned off or prompts have been approved.
ECHO.
ECHO. TERMINATING SCRIPT
ECHO.
PAUSE
EXIT

:EOF 
