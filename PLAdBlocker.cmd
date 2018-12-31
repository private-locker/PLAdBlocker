@ECHO OFF
IF NOT "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
SET "VERS=2.1b"
SET "PROG=PLAdBlocker"
ECHO.
ECHO %PROG% Version %VERS%
ECHO.
ECHO File    : %~n0%~x0 
ECHO Location: %~d0%~p0
ECHO.
%~d0
cd %~d0%~p0
SET LOCAL=%~d0%~p0
SET "PAUSEMUTHAFUCKA=timeout /t 2 /NOBREAK"
SET "HOSTSFILES=HOSTS*.*"
SET "HOSTSPL=HOSTS.PL"
SET "HOSTTEMP=HOSTS.TMP"
SET "SRC=%LOCAL%\src"
SET "HOSTSFILE=%SRC%\HOSTS"
SET "XMRIGHOSTS=%SRC%\xmrig-HOSTS"
SET "XMRIGCCHOSTS=%SRC%\xmrigcc-HOSTS"
SET "MGHOSTS=%SRC%\mg-HOSTS"
SET "XMRSTAKHOSTS=%SRC%\xmrstak-HOSTS"
SET "HOSTS=HOSTS"
SET "STRING1=Private-Locker Adblock"
SET "STRING2=XMRig Dev-Fee Block"
SET "STRING3=MinerGate AdBlock"
SET "STRING4=XMR-Stak Fee Block"
SET "STRING5=XMRigCC Dev-Fee Block"
SET "OSNUM=null"
ECHO We now will detect the Operating System.
%PAUSEMUTHAFUCKA% >NUL
GOTO DETECTOS
:DETECTOS
IF "%OS%"=="Windows_NT" (
	SET "OSNUM=1"
	ECHO Operating System: %OS%
	SET "DIR=%windir%\SYSTEM32\DRIVERS\ETC"
) ELSE (
	SET "OSNUM=2"
	ECHO.
	ECHO Operating System: %OS%
	ECHO.
	SET "DIR=%winbootdir%"
)
GOTO ADBLOCKCHECK

:ADBLOCKCHECK
findstr /i /c:"%STRING1%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	ECHO %STRING1% is Disabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START1
)
IF %ERRORLEVEL% EQU 0 (
	ECHO %STRING1% is Enabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO XMRIGCHECK
)

:XMRIGCHECK
findstr /i /c:"%STRING2%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	ECHO %STRING2% is Disabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START2
)
IF %ERRORLEVEL% EQU 0 (
	ECHO %STRING2% is Enabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO MGCHECK
)

:MGCHECK
findstr /i /c:"%STRING3%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	ECHO %STRING3% is Disabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START3
)
IF %ERRORLEVEL% EQU 0 (
	ECHO %STRING3% is Enabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO XMRSTAKCHECK
)

:XMRSTAKCHECK
findstr /i /c:"%STRING4%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	ECHO %STRING4% is Disabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START4
)
IF %ERRORLEVEL% EQU 0 (
	ECHO %STRING4% is Enabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO XMRIGCCCHECK
)

:XMRIGCCCHECK
findstr /i /c:"%STRING5%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	ECHO %STRING5% is Disabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START5
)
IF %ERRORLEVEL% EQU 0 (
	ECHO %STRING5% is Enabled.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO DONE
)

:START1
SET "CHOICE1=null"
SET /p "CHOICE1=Do you want to add Private-Lockers Adblocker HOSTS File? [Y/N]:  "
IF NOT "%CHOICE1%"=="" SET CHOICE1=%CHOICE1:~0,1%
IF "%CHOICE1%"=="Y" GOTO ADDPLADBLOCK1
IF "%CHOICE1%"=="y" GOTO ADDPLADBLOCK1
IF "%CHOICE1%"=="N" GOTO XMRIGCHECK
IF "%CHOICE1%"=="n" GOTO XMRIGCHECK
IF "%CHOICE1%"=="null" GOTO XMRIGCHECK
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START1

:START2
SET "CHOICE2=null"
SET /p "CHOICE2=Do you want to add Private-Lockers XMRig Dev-Fee Blocker to HOSTS File? [Y/N]:  "
IF NOT "%CHOICE2%"=="" SET CHOICE2=%CHOICE2:~0,1%
IF "%CHOICE2%"=="Y" GOTO ADDPLADBLOCK2
IF "%CHOICE2%"=="y" GOTO ADDPLADBLOCK2
IF "%CHOICE2%"=="N" GOTO MGCHECK
IF "%CHOICE2%"=="n" GOTO MGCHECK
IF "%CHOICE2%"=="null" GOTO MGCHECK
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START2

:START3
SET "CHOICE3=null"
SET /p "CHOICE3=Do you want to add Private-Lockers MinerGate AdBlocker to HOSTS File? [Y/N]:  "
IF NOT "%CHOICE3%"=="" SET CHOICE3=%CHOICE3:~0,1%
IF "%CHOICE3%"=="Y" GOTO ADDPLADBLOCK3
IF "%CHOICE3%"=="y" GOTO ADDPLADBLOCK3
IF "%CHOICE3%"=="N" GOTO XMRSTAKCHECK
IF "%CHOICE3%"=="n" GOTO XMRSTAKCHECK
IF "%CHOICE3%"=="null" GOTO XMRSTAKCHECK
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START3

:START4
SET "CHOICE4=null"
SET /p "CHOICE4=Do you want to add Private-Lockers XMR-Stak Dev-Fee Blocker to HOSTS File? [Y/N]:  "
IF NOT "%CHOICE4%"=="" SET CHOICE4=%CHOICE4:~0,1%
IF "%CHOICE4%"=="Y" GOTO ADDPLADBLOCK4
IF "%CHOICE4%"=="y" GOTO ADDPLADBLOCK4
IF "%CHOICE4%"=="N" GOTO XMRIGCCCHECK
IF "%CHOICE4%"=="n" GOTO XMRIGCCCHECK
IF "%CHOICE4%"=="null" GOTO XMRIGCCCHECK
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START4

:START5
SET "CHOICE5=null"
SET /p "CHOICE5=Do you want to add Private-Lockers XMRigCC Dev-Fee Blocker to HOSTS File? [Y/N]:  "
IF NOT "%CHOICE5%"=="" SET CHOICE5=%CHOICE5:~0,1%
IF "%CHOICE5%"=="Y" GOTO ADDPLADBLOCK5
IF "%CHOICE5%"=="y" GOTO ADDPLADBLOCK5
IF "%CHOICE5%"=="N" GOTO DONE
IF "%CHOICE5%"=="n" GOTO DONE
IF "%CHOICE5%"=="null" GOTO DONE
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START4


:ADDPLADBLOCK1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTSFILE% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO XMRIGCHECK

:ADDPLADBLOCK2
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%XMRIGHOSTS%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%DIR%\%HOSTSPL%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO MGCHECK

:ADDPLADBLOCK3
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%MGHOSTS%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%DIR%\%HOSTSPL%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO XMRSTAKCHECK

:ADDPLADBLOCK4
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%XMRSTAKHOSTS%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%DIR%\%HOSTSPL%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO XMRIGCCCHECK

:ADDPLADBLOCK5
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%XMRIGCCHOSTS%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%DIR%\%HOSTSPL%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO DONE

:DONE
CLS
ECHO Thank you for using this Tool!
ECHO.
ECHO Please Restart your PC for all changes to take affect.
ECHO.
%PAUSEMUTHAFUCKA% >NUL
ECHO Hit [ENTER] to Exit...
pause >NUL
EXIT /B