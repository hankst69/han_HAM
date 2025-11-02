@echo off
rem if exist "%~dp0.nanovna-saver\Scripts\NanoVNASaver.exe" if exist "%~dp0nanovna-saver\src\NanoVNASaver\Windows\ui\about.py" goto :Start

set "_start_dir=%cd%"
set "_this_dir=%~dp0"
set "_maker_dir=%_this_dir%\..\.."

set "_wfv_dir_name=wfview-build"
set "_wfv_dir=C:\Programs\%_wfv_dir_name%"
set "_wfv_dir=%_start_dir%\%_wfv_dir_name%"

call "%_maker_dir%\maker_env.bat"
rem call "%_maker_dir%\ensure" 7z
set "path=%path%;%_maker_dir%\tools"

rem call "%_maker_dir%\ensure" msvs 2022 x64
call "%_maker_dir%\ensure" msvs 2019 x64
call "%_maker_dir%\ensure" qt 6.8.3

cd /d "%_wfv_dir%\.."
if exist "%_wfv_dir_name%" rmdir /s /q "%_wfv_dir_name%"
mkdir "%_wfv_dir_name%"
cd "%_wfv_dir_name%"
call git clone https://gitlab.com/eliggett/wfview.git

rem call qmake "%_wfv_dir_name%\wfview\wfview.pro" CONFIG+=debug
call qmake "%_wfv_dir%\wfview\wfview.pro"

goto :Start


:Start
cd /d "%_start_dir%"
rem call "%_wfv_dir%\bin\wfview.exe"
