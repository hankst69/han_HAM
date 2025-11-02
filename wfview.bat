@echo off
rem if exist "%~dp0.nanovna-saver\Scripts\NanoVNASaver.exe" if exist "%~dp0nanovna-saver\src\NanoVNASaver\Windows\ui\about.py" goto :Start

set "_start_dir=%cd%"
set "_this_dir=%~dp0"
set "_maker_dir=%_this_dir\..\.."

set "_wfv_dir_name=wfview-build"
call "%_maker_dir%\maker_env.bat"

set "_wfv_dir=C:\Programs\%_wfv_dir_name%"
set "_wfv_dir=%_start_dir%\%_wfv_dir_name%"

cd /d "%_wfv_dir%\.."
if exist "%_wfv_dir_name%" rmdir /s /q "%_wfv_dir_name%"
mkdir "%_wfv_dir_name%"
cd "%_wfv_dir_name%"
call git clone https://gitlab.com/eliggett/wfview.git

call ensure qt 6.8.3
call ensure msvs 2019

goto :Start


:Start
cd /d "%_start_dir%"
rem call "%_wfv_dir%\bin\wfview.exe"
