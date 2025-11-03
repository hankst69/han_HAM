@echo off
set "_nvnasvr_dir=%~dp0"
set "_nvnasvr_dir=%cd%"
rem dir "%_nvnasvr_dir%\nanovna-saver\src\NanoVNASaver\Windows\ui\about.*"
if exist "%_nvnasvr_dir%\.nanovna-saver\Scripts\NanoVNASaver.exe" if exist "%_nvnasvr_dir%\nanovna-saver\src\NanoVNASaver\Windows\ui\about.py" goto :_nvnasvr_start

rem create phyton venv and build NanoVnaSaver
call python --version 2>nul
if %ERRORLEVEL% equ 0 goto :_nvnasvr_install
if exist "C:\Programs\Python313\python.exe" set "PATH=C:\Programs\Python313\Scripts;C:\Programs\Python313;%PATH%"
call python --version 2>nul
if %ERRORLEVEL% equ 0 goto :_nvnasvr_install
if exist "C:\ProgramData\Anaconda3\python.exe" set "PATH=C:\ProgramData\Anaconda3\Scripts;C:\ProgramData\Anaconda3;%PATH%"
call python --version 2>nul
if %ERRORLEVEL% equ 0 goto :_nvnasvr_install
echo error: python not available
pause
goto :EOF


:_nvnasvr_install
cd /d "%_nvnasvr_dir%"
rem if exist "nanovna-saver" rmdir /s /q "nanovna-saver" 
git clone -q https://github.com/NanoVNA-Saver/nanovna-saver.git
python -m venv .nanovna-saver
call .nanovna-saver\Scripts\activate
python -m pip install --upgrade pip

cd nanovna-saver
rem call python -m pip install -e .
rem D:\GIT\HAM\nanovna-saver\src\NanoVNASaver\Windows\ui>pyside6-rcc.exe main.qrc -g python -o main_rc.py
echo.
echo pyside6-rcc.exe .\src\NanoVNASaver\Windows\ui\main.qrc -g python -o .\src\NanoVNASaver\Windows\ui\main_rc.py
pyside6-rcc.exe .\src\NanoVNASaver\Windows\ui\main.qrc -g python -o .\src\NanoVNASaver\Windows\ui\main_rc.py
echo pyside6-uic.exe .\src\NanoVNASaver\Windows\ui\about.ui -g python -o .\src\NanoVNASaver\Windows\ui\about.py
pyside6-uic.exe .\src\NanoVNASaver\Windows\ui\about.ui -g python -o .\src\NanoVNASaver\Windows\ui\about.py
echo.
set "PYTHONPATH=%_nvnasvr_dir%\nanovna-saver\src\NanoVNASaver\Windows\ui"
python -m pip install -e .
goto :_nvnasvr_start


:_nvnasvr_start
cd /d "%_nvnasvr_dir%"
call .nanovna-saver\Scripts\activate
set "PYTHONPATH=%_nvnasvr_dir%\nanovna-saver\src\NanoVNASaver\Windows\ui"
"%_nvnasvr_dir%\.nanovna-saver\Scripts\NanoVNASaver.exe"
deactivate
rem pause