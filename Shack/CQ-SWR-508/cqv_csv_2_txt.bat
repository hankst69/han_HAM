@echo off
set "_INP_FILE=%~1"
set "_TMP_FILE=%~dpn1.tmp"
set "_TXT_FILE=%~dpn1.txt"
del /f /q "%_TMP_FILE%"
del /f /q "%_TXT_FILE%"
call :_csv_2_txt "%_INP_FILE%" >"%_TMP_FILE%"
for /f %%l in (%_TMP_FILE%) do if "%%~l" neq "" echo %%l>>"%_TXT_FILE%"
goto :EOF

:_csv_2_txt
for /f "tokens=1-6 delims=," %%a in (%~1) do (
  if "%%~a" equ "Async TX" if "%%~e" neq "\0" (
    rem echo '%%~e'
    rem if "%%~e" equ "ÿ" (
    if "%%~e" equ "Ã¿" (
      echo.
    ) else (
      rem echo '%%~e'
      if "%%~e" equ "=" (
        echo|set /p="::"
      ) else if %%~e equ "" (
        echo|set /p="""
      ) else (
        echo|set /p="%%~e"
      )
    )
  )
)
goto :EOF

