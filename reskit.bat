@echo off
goto :check_admin

:main
cls

echo --------------------------------------------------------------------------
echo 0. Exit                          99. Reboot
echo.
echo 1. Ű���� �ӵ� ������ ����        2. �ѿ���ȯ Shift-Space, �ѱ� ��������
echo 3. �ٿ�ε� Savezone ��Ȱ��ȭ
echo.
echo * Windows 11
echo 4. ���� ��Ȱ��ȭ                  5. CoPilot ��Ȱ��ȭ
echo 6. ��׶���� ����
echo 7. PC�ð��� UTC �μ���
echo.
echo * ����
echo 8. Office 2021 Pro KMS����        9. Office 2021 Pro KMS����(192.168.4.12)
echo 10.Winrar ���
echo.
echo * ��Ÿ
echo 11.Win11 Setup check bypass      12. ���ͳ� ������� ��ġ
echo 13.�⺻ �ӽõ��丮 ����        14. TEMP ����
echo 15.Hostname/Workgroup ����       16. ����� ����� ����
echo 17.Windows App ����
echo.
echo App ���: Get-AppxPackage ^| select Name, PackageFamilyName
echo           Get-AppxPackage -AllUsers ^| select Name, PackageFamilyName
echo App ����: Get-AppxPackage Name ^| Remove-AppxPackage
echo           Get-AppxPackage -AllUsers Name ^| Remove-AppxPackage
echo --------------------------------------------------------------------------
echo.
set /p menunum="����� �����ϼ���: "

If 0%menunum% EQU 0 Exit /B

call :menu_%menunum%
goto :main

:menu_99
shutdown /r /t 0
goto :main

:menu_1
echo Ű���� �ӵ� ������ ����
Reg.exe add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

pause
goto:eof

:menu_2
echo �ѿ���ȯ Shift-Space, �ѱ� ��������
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "LayerDriver KOR" /t REG_SZ /d "kbd101c.dll" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "OverrideKeyboardIdentifier" /t REG_SZ /d "PCAT_101CKEY" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "OverrideKeyboardSubtype" /t REG_DWORD /d "5" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v "OverrideKeyboardType" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d "000000000000000003000000720038E071001DE000000000" /f

pause
goto:eof

:menu_3
echo �ٿ�ε� Savezone ��Ȱ��ȭ
REM ; �ٿ�ε��ϴ� ������ ���� ���� ����
REM ; 0�̸� ����, 1�̸� ���� �� ��.
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f

pause
goto:eof

:menu_4
echo ���� ��Ȱ��ȭ
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f

pause
goto:eof

:menu_5
echo CoPilot ��Ȱ��ȭ
Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f

pause
goto:eof

:menu_6
echo ��׶���� ����
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRuninBackgroud" /t REG_DWORD /d "2" /f

pause
goto:eof


:menu_7
echo PC�ð��� UTC �μ���
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d "1" /f

pause
goto:eof

:menu_8
set office2021_act_status=1
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH

call :office2021_act kms.digiboy.ir
call :office2021_act hq1.chinancce.com
call :office2021_act kms.cnlic.com
call :office2021_act kms.chinancce.com
call :office2021_act kms.digiboy.ir

rem cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus

pause
goto:eof

:menu_9
set office2021_act_status=1
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH

call :office2021_act 192.168.4.12
rem cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus

pause
goto:eof

:menu_10
echo RAR registration data> "C:\Program Files\WinRAR\rarreg.key"
echo kblee>> "C:\Program Files\WinRAR\rarreg.key"
echo Unlimited Company License>> "C:\Program Files\WinRAR\rarreg.key"
echo UID=89cbb27a846039061a44>> "C:\Program Files\WinRAR\rarreg.key"
echo 64122122501a44f42db886bb2c8d0bbaba51eee2ac9ba645de63bb>> "C:\Program Files\WinRAR\rarreg.key"
echo ef95732537ed91e7ec9560fce6cb5ffde62890079861be57638717>> "C:\Program Files\WinRAR\rarreg.key"
echo 7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565>> "C:\Program Files\WinRAR\rarreg.key"
echo b41bcf56929486b8bcdac33d50ecf7739960b166059e5e00cb657d>> "C:\Program Files\WinRAR\rarreg.key"
echo eea1c61312f3e2cd59f8dcffe751fb4bf92cb262336c0eba3de94b>> "C:\Program Files\WinRAR\rarreg.key"
echo 6d71153fcdb61854710408ecbfc09128102d8c01965df10460128a>> "C:\Program Files\WinRAR\rarreg.key"
echo | set /p dummy="e4b7d9da370464fc59e53824f71b2d54307b6e18a0e81324258262">> "C:\Program Files\WinRAR\rarreg.key"

pause
goto:eof

:menu_11
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f

pause
goto:eof

:menu_12
Reg.exe add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /v BypassNRO /t REG_DWORD /d 1 /f

pause
goto:eof

:menu_13
start %SystemRoot%\TEMP
start %USERPROFILE%\AppData\Local\Temp

pause
goto:eof

:menu_14
set /p tmpdir="���丮: "
IF NOT EXIST "%tmpdir%" mkdir "%tmpdir%"
Reg.exe DELETE HKCU\Environment /v TEMP /f
Reg.exe DELETE HKCU\Environment /v TMP /f
setx TEMP "%tmpdir%" /m
setx TMP "%tmpdir%" /m

pause
goto:eof

:menu_15
set /p hostname="HOSTNAME: "
set /p workgroup="WORKGROUP: "

rem Reg.exe add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname /t REG_SZ /d %hostname%
rem Reg.exe add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v "NV Hostname" /t REG_SZ /d %hostname%
rem Reg.exe add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d %hostname%
wmic ComputerSystem Where Name="%COMPUTERNAME%" Call Rename Name="%hostname%"
wmic computersystem where name="%computername%" call joindomainorworkgroup name="%workgroup%"

pause
goto:eof

:menu_16
DISM.exe /Online /Set-ReservedStorageState /State:Disabled

pause
goto:eof

:menu_17
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


:check_admin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Echo You must have administrator rights to continue ... 
 Exit /B
)
goto :main

:office2021_act
if %office2021_act_status%==0 goto:eof
echo.
echo.
echo.
echo ---------------------------------------
echo Activation with %1 ...
echo ---------------------------------------
echo.
if %office2021_act_status%==0 goto:eof

cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /sethst:%1
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act > act_tmp.log
type act_tmp.log
findstr successful act_tmp.log
set office2021_act_status=%errorlevel%

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
