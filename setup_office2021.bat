@echo off

set Word=O
set Excel=O
set PowerPoint=O
set Outlook=O
set OneNote=O
set Access=X
set Publisher=X
set OneDrive=X
set Groove=X
set Lync=X
set Teams=X

:main
cls
echo.
echo 1.  Word        [%Word%]
echo 2.  Excel       [%Excel%]
echo 3.  PowerPoint  [%PowerPoint%]
echo 4.  Outlook     [%Outlook%]
echo 5.  OneNote     [%OneNote%]
echo 6.  Access      [%Access%]
echo 7.  Publisher   [%Publisher%]
echo 8.  OneDrive    [%OneDrive%]
echo 9.  Groove      [%Groove%]
echo 10. Lync        [%Lync%]
echo 11. Teams       [%Teams%]
echo.
echo 91. Install     92. Download
echo 0.  Exit
echo.
set /p menunum="설치항목을 선택하세요: "

If 0%menunum% EQU 0 Exit /B

if  %menunum% EQU 1 (
	if %Word%==O (set Word=X) Else (set Word=O)
)
if  %menunum% EQU 2 (
	if %Excel%==O (set Excel=X) Else (set Excel=O)
)
if  %menunum% EQU 3 (
	if %PowerPoint%==O (set PowerPoint=X) Else (set PowerPoint=O)
)
if  %menunum% EQU 4 (
	if %Outlook%==O (set Outlook=X) Else (set Outlook=O)
)
if  %menunum% EQU 5 (
	if %OneNote%==O (set OneNote=X) Else (set OneNote=O)
)
if  %menunum% EQU 6 (
	if %Access%==O (set Access=X) Else (set Access=O)
)
if  %menunum% EQU 7 (
	if %Publisher%==O (set Publisher=X) Else (set Publisher=O)
)
if  %menunum% EQU 8 (
	if %OneDrive%==O (set OneDrive=X) Else (set OneDrive=O)
)
if  %menunum% EQU 9 (
	if %Groove%==O (set Groove=X) Else (set Groove=O)
)
if  %menunum% EQU 10 (
	if %Lync%==O (set Lync=X) Else (set Lync=O)
)
if  %menunum% EQU 11 (
	if %Teams%==O (set Teams=X) Else (set Teams=O)
)

if  %menunum% EQU 91 (
call :config_tmp
type config_tmp.xml
echo setup /configure config_tmp.xml
pause
)

if  %menunum% EQU 92 (
call :config_tmp
type config_tmp.xml
echo setup /download config_tmp.xml
pause
)

goto :main

:config_tmp
echo ^<Configuration^>>config_tmp.xml
echo   ^<Add OfficeClientEdition="64" Channel="PerpetualVL2021"^>>>config_tmp.xml
echo     ^<Product ID="ProPlus2021Volume" PIDKEY="FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH"^>>>config_tmp.xml
echo       ^<Language ID="ko-kr" /^>>>config_tmp.xml
if %Word%==X (echo        ^<ExcludeApp ID="Word" /^>>>config_tmp.xml)
if %Excel%==X (echo        ^<ExcludeApp ID="Excel" /^>>>config_tmp.xml)
if %PowerPoint%==X (echo        ^<ExcludeApp ID="PowerPoint" /^>>>config_tmp.xml)
if %Outlook%==X (echo        ^<ExcludeApp ID="Outlook" /^>>>config_tmp.xml)
if %OneNote%==X (echo        ^<ExcludeApp ID="OneNote" /^>>>config_tmp.xml)
if %Access%==X (echo        ^<ExcludeApp ID="Access" /^>>>config_tmp.xml)
if %Publisher%==X (echo        ^<ExcludeApp ID="Publisher" /^>>>config_tmp.xml)
if %OneDrive%==X (echo        ^<ExcludeApp ID="OneDrive" /^>>>config_tmp.xml)
if %Groove%==X (echo        ^<ExcludeApp ID="Groove" /^>>>config_tmp.xml)
if %Lync%==X (echo        ^<ExcludeApp ID="Lync" /^>>>config_tmp.xml)
if %Teams%==X (echo        ^<ExcludeApp ID="Teams" /^>>>config_tmp.xml)
echo     ^</Product^>>>config_tmp.xml
echo   ^</Add^>>>config_tmp.xml
echo   ^<Remove All="True" /^>>>config_tmp.xml
echo ^</Configuration^>>>config_tmp.xml
goto:eof