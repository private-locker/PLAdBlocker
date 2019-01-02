@ECHO OFF
IF NOT "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
SET "VERS=2.3"
SET "PROG=PLAdBlocker"
mode con:cols=80 lines=26
TITLE %PROG% - %VERS%
ECHO.
ECHO                       %PROG% Version %VERS%
ECHO.
ECHO File    : %~n0%~x0 
ECHO Location: %~d0%~p0
ECHO.
%~d0
cd %~d0%~p0
SET LOCAL=%~d0%~p0
SET "PAUSEMUTHAFUCKA=timeout /t 2 /NOBREAK"
SET "HOSTSFILES=HOSTS*.*"
SET "HOSTSPL=HOSTS.BACKUP"
SET "HOSTSBACKUP=HOSTS.ORIG"
SET "HOSTTEMP=HOSTS.TMP"
SET "CUSTOM=CUSTOMHOSTS"
SET "SRC=%LOCAL%\src"
SET "CUSTOMHOSTS=%SRC%\%CUSTOM%
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
SET "STRING6=Private-Locker Custom File"
SET "OSNUM=null"
SET "NUMCHK=0"
SET "ADNUM=0"
ECHO We now will detect the Operating System Architecture..
ECHO.
%PAUSEMUTHAFUCKA% >NUL
GOTO DETECTOS
:DETECTOS
IF "%OS%"=="Windows_NT" (
	SET "OSNUM=1"
	ECHO - %OS%
	SET "DIR=%windir%\SYSTEM32\DRIVERS\ETC"
) ELSE (
	SET "OSNUM=2"
	ECHO.
	ECHO - %OS%
	ECHO.
	SET "DIR=%winbootdir%"
)
%PAUSEMUTHAFUCKA%>NUL
GOTO START0

:ADBLOCKCHECK
IF NOT EXIST "%LOCAL%\src\%HOSTS%" (
	CLS
	ECHO.
	ECHO Do you want to Install:
	ECHO.
	GOTO XMRIGCHECK
)
findstr /i /c:"%STRING1%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	%PAUSEMUTHAFUCKA% >NUL
	GOTO INSTALL
)
IF %ERRORLEVEL% EQU 0 (
	SET /a NUMCHK+=1
	ECHO.
	ECHO Do you want to Install:
	ECHO.
	ECHO   - %STRING1% is Installed already.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO XMRIGCHECK
)

:XMRIGCHECK
findstr /i /c:"%STRING2%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START2
)
IF %ERRORLEVEL% EQU 0 (
	SET /a NUMCHK+=1
	ECHO   - %STRING2% is Installed already.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO MGCHECK
)

:MGCHECK
findstr /i /c:"%STRING3%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START3
)
IF %ERRORLEVEL% EQU 0 (
	SET /a NUMCHK+=1
	ECHO   - %STRING3% is Installed already.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO XMRSTAKCHECK
)

:XMRSTAKCHECK
findstr /i /c:"%STRING4%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START4
)
IF %ERRORLEVEL% EQU 0 (
	SET /a NUMCHK+=1
	ECHO   - %STRING4% is Installed already.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO XMRIGCCCHECK
)

:XMRIGCCCHECK
findstr /i /c:"%STRING5%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START5
)
IF %ERRORLEVEL% EQU 0 (
	SET /a NUMCHK+=1
	ECHO   - %STRING5% is Installed already.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO DONE
)

:CUSTOMCHECK
findstr /i /c:"%STRING6%" "%DIR%\%HOSTS%" >NUL
IF %ERRORLEVEL% EQU 1 (
	%PAUSEMUTHAFUCKA% >NUL
	GOTO START6
)
IF %ERRORLEVEL% EQU 0 (
	SET /a NUMCHK+=1
	ECHO   - %STRING6% is Installed already.
	%PAUSEMUTHAFUCKA% >NUL
	GOTO DONE
)


:START0
CLS
ECHO.
ECHO                       %PROG% Version %VERS%
ECHO.
IF NOT EXIST "%LOCAL%\src\%HOSTS%" (
	ECHO          !! There is NO %HOSTS% File in this script! !!
	ECHO   !! Please [U]pdate to Download a new copy of the %HOSTS% File. !!
	ECHO.
) ELSE (
	ECHO.
	ECHO.
	ECHO.
)
ECHO                   C - Clear %HOSTS% to Windows Stock %HOSTS% File
ECHO                   B - Backup %HOSTS% File
ECHO                   R - Restore %HOSTS% from %HOSTSBACKUP%
ECHO                   I - Installs %PROG%
ECHO                   U - Downloads Current AdBlocker %HOSTS% File
ECHO                   E - Exits this Program
ECHO.
SET "CHOICE0="
SET /p "CHOICE0=Please Select a Option [C/B/R/I/U/E]:  "
IF NOT "%CHOICE0%"=="" SET CHOICE0=%CHOICE0:~0,1%
IF "%CHOICE0%"=="I" CLS && GOTO ADBLOCKCHECK
IF "%CHOICE0%"=="i" CLS && GOTO ADBLOCKCHECK
IF "%CHOICE0%"=="B" GOTO BACKUP
IF "%CHOICE0%"=="b" GOTO BACKUP
IF "%CHOICE0%"=="C" GOTO CLEARHOSTS
IF "%CHOICE0%"=="c" GOTO CLEARHOSTS
IF "%CHOICE0%"=="E" GOTO DONE
IF "%CHOICE0%"=="e" GOTO DONE
IF "%CHOICE0%"=="R" GOTO RESTORE
IF "%CHOICE0%"=="r" GOTO RESTORE
IF "%CHOICE0%"=="U" GOTO PULLNEW
IF "%CHOICE0%"=="u" GOTO PULLNEW
ECHO.
ECHO Wrong choice, Please select one of the following choices.
ECHO.
ECHO C - Clear %HOSTS% to Windows Stock %HOSTS% File
ECHO B - Backup %HOSTS% File
ECHO R - Restore %HOSTS% from %HOSTSBACKUP%
ECHO I - Installs %PROG%
ECHO U - Update %HOSTS% File
ECHO E - Exits this Program
ECHO.
%PAUSEMUTHAFUCKA% >NUL
GOTO START0

:INSTALL
CLS
ECHO.
ECHO Do you want to Install:
ECHO.
GOTO START1

:START1
SET "CHOICE1=null"
SET /p "CHOICE1= - Private-Lockers Adblocker HOSTS File (MVPS)? [Y/N]:  "
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
SET /p "CHOICE2= - Private-Lockers XMRig Dev-Fee Blocker? [Y/N]:  "
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
SET /p "CHOICE3= - Private-Lockers MinerGate Ad Blocker? [Y/N]:  "
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
SET /p "CHOICE4= - Private-Lockers XMR-Stak Dev-Fee Blocker? [Y/N]:  "
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
SET /p "CHOICE5= - Private-Lockers XMRigCC Dev-Fee Blocker? [Y/N]:  "
IF NOT "%CHOICE5%"=="" SET CHOICE5=%CHOICE5:~0,1%
IF "%CHOICE5%"=="Y" GOTO ADDPLADBLOCK5
IF "%CHOICE5%"=="y" GOTO ADDPLADBLOCK5
IF "%CHOICE5%"=="N" (
	IF EXIST "%LOCAL%\src\%CUSTOM%" GOTO CUSTOMCHECK
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
IF "%CHOICE5%"=="n" (
	IF EXIST "%LOCAL%\src\%CUSTOM%" GOTO CUSTOMCHECK
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
IF "%CHOICE5%"=="null" (
	IF EXIST "%LOCAL%\src\%CUSTOM%" GOTO CUSTOMCHECK
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START5

:START6
SET "CHOICE6=null"
SET /p "CHOICE6= - Custom %HOSTS% File? [Y/N]:  "
IF NOT "%CHOICE6%"=="" SET CHOICE5=%CHOICE6:~0,1%
IF "%CHOICE6%"=="Y" GOTO CUSTOMADBLOCK
IF "%CHOICE6%"=="y" GOTO CUSTOMADBLOCK
IF "%CHOICE6%"=="N" (
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
IF "%CHOICE6%"=="n" (
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
IF "%CHOICE6%"=="null" (
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO START6


:ADDPLADBLOCK1
%PAUSEMUTHAFUCKA% >NUL
SET /a ADNUM+=1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %LOCAL%\src\%HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO XMRIGCHECK

:ADDPLADBLOCK2
%PAUSEMUTHAFUCKA% >NUL
SET /a ADNUM+=1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%DIR%\%HOSTSPL%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%XMRIGHOSTS%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO MGCHECK

:ADDPLADBLOCK3
%PAUSEMUTHAFUCKA% >NUL
SET /a ADNUM+=1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%DIR%\%HOSTSPL%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%MGHOSTS%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO XMRSTAKCHECK

:ADDPLADBLOCK4
%PAUSEMUTHAFUCKA% >NUL
SET /a ADNUM+=1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%DIR%\%HOSTSPL%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%XMRSTAKHOSTS%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
GOTO XMRIGCCCHECK

:ADDPLADBLOCK5
%PAUSEMUTHAFUCKA% >NUL
SET /a ADNUM+=1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%DIR%\%HOSTSPL%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%XMRIGCCHOSTS%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
IF NOT EXIST "%LOCAL%\src\%CUSTOM%" (
	IF "%ADNUM%" GEQ "1" GOTO FIX 
	IF "%ADNUM%" EQU "0" GOTO DONE
)
IF EXIST "%LOCAL%\src\%CUSTOM%" GOTO CUSTOMCHECK

:CUSTOMADBLOCK
%PAUSEMUTHAFUCKA% >NUL
SET /a ADNUM+=1
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTSPL%" (
	TYPE "%DIR%\%HOSTSPL%" > "%LOCAL%\%HOSTTEMP%"
	TYPE "%CUSTOMHOSTS%" >> "%LOCAL%\%HOSTTEMP%"
)
IF EXIST "%LOCAL%\%HOSTTEMP%" REN "%LOCAL%\%HOSTTEMP%" %HOSTS%>NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y %HOSTS% "%DIR%">NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
IF "%ADNUM%" GEQ "1" GOTO FIX 
IF "%ADNUM%" EQU "0" GOTO DONE

:RESTORE
IF NOT EXIST "%DIR%\%HOSTSBACKUP%" (
	ECHO No %HOSTSBACKUP% File present. Please use the Backup Option when Valid %HOSTS% File is installed.
	%PAUSEMUTHAFUCKA% >NUL
	ECHO Hit [ENTER] to return to Prompt...
	pause >NUL
	GOTO START0
) ELSE (
	IF EXIST "%DIR%\%HOSTS%" DEL "%DIR%\%HOSTS%">NUL
	IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y "%DIR%\%HOSTSBACKUP%" "%DIR%\%HOSTS%">NUL
	IF %ERRORLEVEL% EQU 0 (
		ECHO %HOSTS% File Restore Successful.
		ECHO.
		ECHO %HOSTS% File Restore:
		ECHO.
		ECHO Location : %DIR%
		ECHO Backup   : %HOSTSBACKUP%
		ECHO File     : %HOSTS%
		ECHO.
	)
	IF %ERRORLEVEL% EQU 1 (
		ECHO %HOSTS% File Restore Failed.
	)
)
%PAUSEMUTHAFUCKA% >NUL
ECHO Hit [ENTER] to return to Prompt...
pause >NUL
GOTO START0

:BACKUP 
IF NOT EXIST "%DIR%\%HOSTS%" (
	ECHO No %HOSTS% File present. Please Install %PROG% or Another %HOSTS% File.
	%PAUSEMUTHAFUCKA% >NUL
	ECHO Hit [ENTER] to return to Prompt...
	pause >NUL
	GOTO START0
) 
IF EXIST "%DIR%\%HOSTSFILES%" ATTRIB +A -H -R -S "%DIR%\%HOSTSFILES%">NUL
IF EXIST "%DIR%\%HOSTSBACKUP%" DEL "%DIR%\%HOSTSBACKUP%">NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSBACKUP%>NUL
IF %ERRORLEVEL% EQU 0 (
	ECHO %HOSTS% File Backup Successful.
	ECHO.
	ECHO %HOSTS% File Backup:
	ECHO.
	ECHO Location : %DIR%
	ECHO File     : %HOSTSBACKUP%
	ECHO.
)
IF %ERRORLEVEL% EQU 1 (
	ECHO %HOSTS% File Backup Failed.
)
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y "%DIR%\%HOSTSBACKUP%" "%DIR%\%HOSTS%">NUL
%PAUSEMUTHAFUCKA% >NUL
ECHO Hit [ENTER] to return to Prompt...
pause >NUL
GOTO START0

:PULLNEW
SET "MVPS=http://winhelp2002.mvps.org/hosts.txt"
IF EXIST "%LOCAL%\src\%HOSTS%" DEL "%LOCAL%\src\%HOSTS%">NUL
IF NOT EXIST "%LOCAL%\src\%HOSTS%" (
	WHERE BITSADMIN.EXE >NUL
	IF "%ERRORLEVEL%" == "1" (
		ECHO No BITSADMIN Module Detected in this Version of Windows.
	)
	ECHO Downloading new %HOSTS% File from %MVPS%..
	ECHO Please Wait..
	BITSADMIN /transfer "UPDATE" /download /priority HIGH "%MVPS%" "%LOCAL%\src\%HOSTS%" >NUL
	IF %ERRORLEVEL% EQU 0 (
		ECHO Download of Current %HOSTS% File completed.
		ECHO # %STRING1% - %VERS% > "%LOCAL%\src\%HOSTSBACKUP%"
		ECHO # >> "%LOCAL%\src\%HOSTSBACKUP%"
		TYPE "%LOCAL%\src\%HOSTS%" >> "%LOCAL%\src\%HOSTSBACKUP%"
		IF EXIST "%LOCAL%\src\%HOSTS%"  DEL "%LOCAL%\src\%HOSTS%" >NUL
		IF EXIST "%LOCAL%\src\%HOSTSBACKUP%" REN "%LOCAL%\src\%HOSTSBACKUP%" %HOSTS% >NUL
		ECHO Replacement of OLD %HOSTS% with NEW %HOSTS% completed.
	)
	IF %ERRORLEVEL% EQU 1 (
		ECHO Could Not Download Current %HOSTS% File.
	)
) ELSE (
	ECHO Could not download new %HOSTS% File.
)
%PAUSEMUTHAFUCKA% >NUL
ECHO Hit [ENTER] to return to Prompt...
pause >NUL
GOTO START0

:CLEARHOSTSPROMPT
CLS
SET "CLRHOST1=null"
SET /p "CLRHOST1=ARE YOU SURE YOU WANT TO WIPE YOUR HOSTS FILE? [Y/N]:  "
IF NOT "%CLRHOST1%"=="" SET CLRHOST1=%CLRHOST1:~0,1%
IF "%CLRHOST1%"=="Y" GOTO CLEARHOSTS
IF "%CLRHOST1%"=="y" GOTO CLEARHOSTS
IF "%CLRHOST1%"=="N" GOTO START0
IF "%CLRHOST1%"=="n" GOTO START0
IF "%CLRHOST1%"=="null" GOTO START0
ECHO Wrong choice, please select [Y]es or [N]o.
ECHO.
GOTO CLEARHOSTSPROMPT

:CLEARHOSTS
IF EXIST "%DIR%\%HOSTS%" DEL "%DIR%\%HOSTS%" >NUL
ECHO Wiping %HOSTS% File at %DIR%
ECHO 127.0.0.1 localhost > "%DIR%\%HOSTS%"
ECHO. >> "%DIR%\%HOSTS%"
ECHO ::1 localhost #[IPv6] >> "%DIR%\%HOSTS%"
ECHO Restored %HOSTS% File to Stock Windows %HOSTS% File.
ECHO Removing %HOSTSBACKUP% from %DIR%
IF EXIST "%DIR%\%HOSTSBACKUP%" DEL "%DIR%\%HOSTSBACKUP%">NUL
ECHO Removing %HOSTSPL% from %DIR%
IF EXIST "%DIR%\%HOSTSPL%" DEL "%DIR%\%HOSTSPL%">NUL
ECHO.
ECHO Completed.
%PAUSEMUTHAFUCKA% >NUL
ECHO Hit [ENTER] to return to Prompt...
pause >NUL
GOTO START0

:FIX
FINDSTR /V /I "127.0.0.1 localhost" "%DIR%\%HOSTS%" >NUL
IF "%ERRORLEVEL%" == "0" GOTO DONE
PAUSE
CLS
SET "CONTENT1=127.0.0.1 localhost"
SET "CONTENT2=::1 localhost #[IPv6]"
ECHO.
ECHO Fixing Errors for localhost..
ECHO %CONTENT1% > "%LOCAL%\%HOSTS%"
ECHO. >> "%LOCAL%\%HOSTS%"
TYPE "%DIR%\%HOSTS%" >> "%LOCAL%\%HOSTS%"
IF EXIST "%LOCAL%\%HOSTSPL%" DEL "%LOCAL%\%HOSTSPL%" >NUL
IF EXIST "%DIR%\%HOSTS%" REN "%DIR%\%HOSTS%" %HOSTSPL%>NUL
IF EXIST "%DIR%\%HOSTS%" DEL "%DIR%\%HOSTS%" >NUL
IF NOT EXIST "%DIR%\%HOSTS%" COPY /Y "%LOCAL%\%HOSTS%" "%DIR%" >NUL
IF EXIST "%LOCAL%\%HOSTS%" DEL "%LOCAL%\%HOSTS%" >NUL
%PAUSEMUTHAFUCKA%>NUL
GOTO DONE

:DONE
IF "%NUMCHK%" GEQ "5" ECHO Blocks are installed in %HOSTS% already.
ECHO.
ECHO Thank you for using this Tool!
ECHO.
ECHO Please Restart your PC for all changes to take affect.
ECHO.
%PAUSEMUTHAFUCKA% >NUL
ECHO Hit [ENTER] to Exit...
pause >NUL
EXIT /B