@REM Author: Zachary Turner 
@REM This script is a simple implementation of the Unix 'ls' command
@REM in Windows batch scripting. It provides options for long listing format, showing hidden files,
@echo off
setlocal enabledelayedexpansion

:: Display help if no arguments or /? is passed
if "%~1"=="" (
    echo Usage: ls.bat [options]
    echo.
    echo Options:
    echo   -l    Long listing format
    echo   -a    Show hidden files
    echo   -h    Human-readable file sizes
    exit /b
)

:: Parse arguments
set "options="
for %%i in (%*) do (
    if "%%i"=="-l" set "options=!options! /Q /N"
    if "%%i"=="-a" set "options=!options! /A"
    if "%%i"=="-h" set "human_readable=1"
)

:: Execute dir command
if defined human_readable (
    for /f "tokens=*" %%A in ('dir %options%') do (
        echo %%A | findstr /r /c:"[0-9][0-9]* bytes" >nul && (
            for /f "tokens=1,2 delims= " %%B in ("%%A") do (
                set "size=%%B"
                call :convert_size !size!
                echo %%A | sed "s/%%B bytes/!size!/"
            )
        ) || echo %%A
    )
) else (
    dir %options%
)

exit /b

:convert_size
set "size=%~1"
set "units=bytes"
if %size% GEQ 1024 (
    set /a size=size/1024
    set "units=KB"
)
if %size% GEQ 1024 (
    set /a size=size/1024
    set "units=MB"
)
if %size% GEQ 1024 (
    set /a size=size/1024
    set "units=GB"
)
set "size=%size% %units%"
exit /b