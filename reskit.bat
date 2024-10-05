@echo off
goto :check_admin

:main
cls

echo --------------------------------------------------------------------------
echo  0. Exit                          99. Reboot
echo.
echo  1. 키보드 속도 빠르게 설정        2. 한영전환 Shift-Space, 한글 동시지원
echo  3. 다운로드 Savezone 비활성화
echo.
echo * Windows 설정
echo  4. 위젯 비활성화 (11)             5. CoPilot 비활성화 (11)
echo  6. 백그라운드앱 중지              7. Explorer 기본설정
echo  8. Hostname/Workgroup 변경        9. 예약된 저장소 삭제
echo 10. Windows App 삭제              11. TEMP 변경
echo 12. cmd process 설정(autorun.cmd) 13. 기본 임시디렉토리 오픈
echo 14. PC시간을 UTC 로설정
echo.
echo * 기타
echo 15. 드라이브백업                  16. 드라이브복원
echo 17. Win11 Setup check bypass      18. 인터넷 연결없이 설치
echo 19. 업데이트 백업파일 제거
echo.
echo * Office
echo 20. MS Office
echo --------------------------------------------------------------------------
echo.
set menunum=
set /p menunum="기능을 선택하세요: "

If 0%menunum% EQU 0 Exit /B

call :mainmenu_%menunum%
goto :main

:mainmenu_99
shutdown /r /t 0
goto:eof

:mainmenu_1
echo 키보드 속도 빠르게 설정
Reg.exe add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

pause
goto:eof

:mainmenu_2
echo 한영전환 Shift-Space, 한글 동시지원
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "LayerDriver KOR" /t REG_SZ /d "kbd101c.dll" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "OverrideKeyboardIdentifier" /t REG_SZ /d "PCAT_101CKEY" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "OverrideKeyboardSubtype" /t REG_DWORD /d "5" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "OverrideKeyboardType" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d "000000000000000003000000720038E071001DE000000000" /f

pause
goto:eof

:mainmenu_3
echo 다운로드 Savezone 비활성화
REM ; 다운로드하는 파일의 보안 정보 저장
REM ; 0이면 저장, 1이면 저장 안 함.
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f

pause
goto:eof

:mainmenu_4
echo 위젯 비활성화
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f

pause
goto:eof

:mainmenu_5
echo CoPilot 비활성화
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f

pause
goto:eof

:mainmenu_6
echo 백그라운드앱 중지
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRuninBackgroud" /t REG_DWORD /d "2" /f

pause
goto:eof

:mainmenu_7
echo Explorer 기본설정
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneShowAllFolders" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneExpandToCurrentFolder" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecommendations" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowCloudFilesInQuickAccess" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "1" /f

taskkill /F /IM explorer.exe
explorer.exe

pause
goto:eof

:mainmenu_8
set /p hostname="HOSTNAME: "
set /p workgroup="WORKGROUP: "

powershell -c "Add-Computer -WorkGroupName %workgroup%"
powershell -c "Rename-Computer -NewName %hostname%"

pause
goto:eof

:mainmenu_9
DISM.exe /Online /Set-ReservedStorageState /State:Disabled

pause
goto:eof

:mainmenu_10
powershell -Command "Get-AppxPackage -AllUsers Clipchamp.Clipchamp                    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.549981C3F5F10                | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.BingNews                     | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.BingWeather                  | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.GamingApp                    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.GetHelp                      | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.Getstarted                   | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.MicrosoftOfficeHub           | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.MicrosoftStickyNotes         | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.People                       | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.PowerAutomateDesktop         | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.Todos                        | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.Windows.Photos               | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.WindowsAlarms                | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.WindowsCamera                | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.WindowsFeedbackHub           | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.WindowsMaps                  | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.WindowsSoundRecorder         | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.Xbox.TCUI                    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.YourPhone                    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.ZuneMusic                    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.ZuneVideo                    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers MicrosoftCorporationII.QuickAssist     | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers microsoft.windowscommunicationsapps    | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.OutlookForWindows            | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers MicrosoftCorporationII.MicrosoftFamily | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers MSTeams                                | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.Copilot                      | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.BingNews                     | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.BingSearch                   | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers Microsoft.BingWeather                  | Remove-AppxPackage"

REM Microsoft.WindowsMaps
REM sc delete MapsBroker
REM sc delete lfsvc
REM schtasks /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /disable
REM schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /disable
REM Remove Package
REM Get-AppxPackage -allusers *Microsoft.Office.Sway* | Remove-AppxPackage
REM Get-AppxPackage -allusers *Microsoft.Office.Desktop* | Remove-AppxPackage
REM Get-AppxPackage -allusers MicrosoftTeams | Remove-AppxPackage
REM Get-AppxPackage -allusers *3dbuilder* | Remove-AppxPackage
REM Get-AppxPackage -AllUsers *onenote* | Remove-AppxPackage
REM Get-AppxPackage -AllUsers Disney.37853FC22B2CE  | Remove-AppxPackage
REM Get-AppxPackage -AllUsers *SkypeApp* | Remove-AppxPackage
REM Get-AppxPackage -AllUsers *SpotifyAB.SpotifyMusic* | Remove-AppxPackage
REM Get-AppxPackage -AllUsers *xbox* | Remove-AppxPackage
REM sc delete XblAuthManager
REM sc delete XblGameSave
REM sc delete XboxNetApiSvc
REM sc delete XboxGipSvc
REM reg delete "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /f
REM schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable
REM schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /disable
REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
pause
goto:eof

:mainmenu_11
set /p tmpdir="디렉토리: "
IF NOT EXIST "%tmpdir%" mkdir "%tmpdir%"
Reg.exe DELETE HKCU\Environment /v TEMP /f
Reg.exe DELETE HKCU\Environment /v TMP /f
setx TEMP "%tmpdir%" /m
setx TMP "%tmpdir%" /m

pause
goto:eof

:mainmenu_12
Reg.exe add "HKLM\SOFTWARE\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "C:\home\autorun.cmd" /f
IF NOT EXIST C:\home\autorun.cmd (
	echo @echo off > C:\home\autorun.cmd
	echo doskey ls=dir $* >> C:\home\autorun.cmd
	echo doskey sudo=c:\usr\bin\gsudo.exe $* >> C:\home\autorun.cmd
	echo @echo on >> C:\home\autorun.cmd
)

pause
goto:eof


:mainmenu_13
start %SystemRoot%\TEMP
start %USERPROFILE%\AppData\Local\Temp

pause
goto:eof


:mainmenu_14
echo PC시간을 UTC 로설정
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d "1" /f

pause
goto:eof

:mainmenu_15
set /p DRVDIR="디렉토리: "
IF NOT EXIST "%DRVDIR%" mkdir "%DRVDIR%"
Dism.exe /Online /Export-Driver "/Destination:%DRVDIR%"

pause
goto:eof

:mainmenu_16
set /p DRVDIR="디렉토리: "
pnputil.exe /add-driver "%DRVDIR%\*.inf" /subdirs /install
start devmgmt.msc

pause
goto:eof

:mainmenu_17
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f

pause
goto:eof

:mainmenu_18
Reg.exe add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /v BypassNRO /t REG_DWORD /d 1 /f

pause
goto:eof


:mainmenu_19
dism /online /Cleanup-Image /StartComponentCleanup /ResetBase

pause
goto:eof

:mainmenu_20
goto :officemenu

goto:eof

:check_admin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Echo You must have administrator rights to continue ... 
 Exit /B
)
goto :main

REM =================================================================================

:officemenu
set Word=O
set Excel=O
set PowerPoint=O
set Outlook=O
set OneNote=O
set Access=X
set Publisher=X
set OneDrive=X
set Lync=X
set Bing=X
set Teams=X

:officemain
cls

echo --------------------------------------------------------------------------
echo * 설치할 항목선택
echo  1.  Word        [%Word%]                 2.  Excel       [%Excel%]
echo  3.  PowerPoint  [%PowerPoint%]                 4.  Outlook     [%Outlook%]
echo  5.  OneNote     [%OneNote%]                 6.  Access      [%Access%]
echo  7.  Publisher   [%Publisher%]                 8.  OneDrive    [%OneDrive%]
echo  9.  Lync        [%Lync%]                10.  Teams       [%Teams%]
echo 11.  Bing (2024) [%Bing%]
echo.
echo 21. Office Install                  22. Office Download
echo 23. office uninstall
echo.
echo * Office License 및 PID 설정
echo 31. Office 2016                     32. Office 2019
echo 33. Office 2021                     34. Office 2024
echo.
echo 41. KMS인증 (외부)                  42. KMS인증 (사용자 지정)
echo 43. 라이선스 정보 보기              44. 전체 License Key 제거
echo.
echo * Office 기타 설정
echo 51. Excel 기본글꼴(본문 글꼴,9)     52. OneNote Tray Icon 제거
echo.
echo  0. return Main
echo --------------------------------------------------------------------------
set menunum=
set /p menunum="설치항목을 선택하세요: "

If 0%menunum% EQU 0 goto :main

call :officemenu_%menunum%
goto :officemain


:officemenu_1
if %Word%==O (set Word=X) Else (set Word=O)
goto:eof

:officemenu_2
if %Excel%==O (set Excel=X) Else (set Excel=O)
goto:eof

:officemenu_3
if %PowerPoint%==O (set PowerPoint=X) Else (set PowerPoint=O)
goto:eof

:officemenu_4
if %Outlook%==O (set Outlook=X) Else (set Outlook=O)
goto:eof

:officemenu_5
if %OneNote%==O (set OneNote=X) Else (set OneNote=O)
goto:eof

:officemenu_6
if %Access%==O (set Access=X) Else (set Access=O)
goto:eof

:officemenu_7
if %Publisher%==O (set Publisher=X) Else (set Publisher=O)
goto:eof

:officemenu_8
if %OneDrive%==O (set OneDrive=X) Else (set OneDrive=O)
goto:eof

:officemenu_9
if %Lync%==O (set Lync=X) Else (set Lync=O)
goto:eof

:officemenu_10
if %Teams%==O (set Teams=X) Else (set Teams=O)
goto:eof

:officemenu_11
if %Bing%==O (set Bing=X) Else (set Bing=O)
goto:eof


:officemenu_21
call :config_tmp_install
type "%~dp0config_tmp.xml"
pause
IF NOT EXIST "%~dp0setup.exe" curl -o "%~dp0setup.exe" https://raw.githubusercontent.com/kblee0/win_res_kit/main/setup.exe
"%~dp0setup.exe" /configure "%~dp0config_tmp.xml"
pause
goto:eof


:officemenu_22
call :config_tmp_install
type "%~dp0config_tmp.xml"
IF NOT EXIST "%~dp0setup.exe" curl -o "%~dp0setup.exe" https://raw.githubusercontent.com/kblee0/win_res_kit/main/setup.exe
"%~dp0setup.exe" /download "%~dp0config_tmp.xml"
pause
goto:eof


:officemenu_23
call :config_tmp_uninstall
type "%~dp0uninstall.xml"
pause
"%~dp0setup.exe" /configure "%~dp0uninstall.xml"
pause
goto:eof


:officemenu_31
rem office 2016
pushd %ProgramFiles%\Microsoft Office\Office16

for /f %%x in ('dir /b ..\root\Licenses16\ProPlusVL_KMS*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x"

cscript ospp.vbs /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99

popd
pause
goto:eof


:officemenu_32
rem office 2019
pushd %ProgramFiles%\Microsoft Office\Office16

for /f %%x in ('dir /b ..\root\Licenses16\ProPlus2019VL_KMS*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x"

cscript ospp.vbs /inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP

popd
pause
goto:eof


:officemenu_33
rem office 2021
pushd %ProgramFiles%\Microsoft Office\Office16

for /f %%x in ('dir /b ..\root\Licenses16\ProPlus2021VL_KMS*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x"

cscript ospp.vbs /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH

popd
pause
goto:eof


:officemenu_34
rem office 2024 Preview
pushd %ProgramFiles%\Microsoft Office\Office16

for /f %%x in ('dir /b dir /b ..\root\Licenses16\ProPlus2024VL_KMS*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x"

cscript ospp.vbs /inpkey:XJ2XN-FW8RK-P4HMP-DKDBV-GCVGB

popd
pause
goto:eof



:officemenu_41
set office_act_status=1

call :office_activate kms.digiboy.ir
call :office_activate hq1.chinancce.com
call :office_activate kms.cnlic.com
call :office_activate kms.chinancce.com
call :office_activate kms.digiboy.ir

rem cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus

pause
goto:eof


:officemenu_42
set office_act_status=1
set kmshost=

set /p kmshost=KMS server host name or ip: 

call :office_activate %kmshost%
rem cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus

pause
goto:eof


:officemenu_43
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus

pause
goto:eof


:officemenu_44
for /f "tokens=8 usebackq" %%x in (`cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus ^| findstr "installed product key:"`) do (
	echo unpkey : %%x
	cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /unpkey:%%x
)

pause
goto:eof


:officemenu_51
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\Excel\Options" /v "Font" /t REG_SZ /d "본문 글꼴,9" /f
pause
goto:eof


:officemenu_52
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OneNote\Options\Other" /v "RunSystemTrayApp" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Office\16.0\OneNote\Options\Other" /v "SystemTrayAppDefaultBehavior" /t REG_DWORD /d "2" /f
pause
goto:eof


goto :officemain

:config_tmp_install
echo ^<Configuration^>>"%~dp0config_tmp.xml"
echo   ^<Add OfficeClientEdition="64" Channel="Current"^>>>"%~dp0config_tmp.xml"
echo     ^<Product ID="O365ProPlusRetail"^>>>"%~dp0config_tmp.xml"
echo       ^<Language ID="ko-kr" /^>>>"%~dp0config_tmp.xml"
if %Word%==X (echo        ^<ExcludeApp ID="Word" /^>>>"%~dp0config_tmp.xml")
if %Excel%==X (echo        ^<ExcludeApp ID="Excel" /^>>>"%~dp0config_tmp.xml")
if %PowerPoint%==X (echo        ^<ExcludeApp ID="PowerPoint" /^>>>"%~dp0config_tmp.xml")
if %Outlook%==X (echo        ^<ExcludeApp ID="Outlook" /^>>>"%~dp0config_tmp.xml")
if %OneNote%==X (echo        ^<ExcludeApp ID="OneNote" /^>>>"%~dp0config_tmp.xml")
if %Access%==X (echo        ^<ExcludeApp ID="Access" /^>>>"%~dp0config_tmp.xml")
if %Publisher%==X (echo        ^<ExcludeApp ID="Publisher" /^>>>"%~dp0config_tmp.xml")
if %OneDrive%==X (echo        ^<ExcludeApp ID="OneDrive" /^>>>"%~dp0config_tmp.xml")
if %OneDrive%==X (echo        ^<ExcludeApp ID="Groove" /^>>>"%~dp0config_tmp.xml")
if %Teams%==X (echo        ^<ExcludeApp ID="Teams" /^>>>"%~dp0config_tmp.xml")
if %Lync%==X (echo        ^<ExcludeApp ID="Lync" /^>>>"%~dp0config_tmp.xml")
if %Bing%==X (echo        ^<ExcludeApp ID="Bing" /^>>>"%~dp0config_tmp.xml")
echo     ^</Product^>>>"%~dp0config_tmp.xml"
echo     ^<Product ID="ProofingTools"^>>>"%~dp0config_tmp.xml"
echo       ^<Language ID="ko-kr" /^>>>"%~dp0config_tmp.xml"
echo     ^</Product^>>>"%~dp0config_tmp.xml"
echo   ^</Add^>>>"%~dp0config_tmp.xml"
echo   ^<Display Level="Full" AcceptEULA="TRUE" /^>>>"%~dp0config_tmp.xml"
echo   ^<Updates Enabled="TRUE" /^>>>"%~dp0config_tmp.xml"
echo ^</Configuration^>>>"%~dp0config_tmp.xml"
goto:eof

:config_tmp_uninstall
echo ^<Configuration^>>"%~dp0uninstall.xml"
echo   ^<Remove All="TRUE" /^>>>"%~dp0uninstall.xml"
echo ^</Configuration^>>>"%~dp0uninstall.xml"
goto:eof

:office_activate

if %office_act_status%==0 goto:eof
echo.
echo.
echo.
echo ---------------------------------------
echo Activation with %1 ...
echo ---------------------------------------
echo.

cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /sethst:%1
for /f "usebackq" %%x in (`cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act ^| findstr "successful"`) do (
	set office_act_status=0
)

goto:eof



goto :skipend

REM Online KMS Server (https://gist.github.com/mokoshalb/b87326bbb62805e94da72f8d0f73f563)

kms.digiboy.ir
hq1.chinancce.com
54.223.212.31
kms.cnlic.com
kms.chinancce.com
kms.ddns.net
franklv.ddns.net
k.zpale.com
m.zpale.com
mvg.zpale.com
kms.shuax.com
kensol263.imwork.net:1688
xykz.f3322.org
kms789.com
dimanyakms.sytes.net:1688
kms.03k.org:1688

:skipend
