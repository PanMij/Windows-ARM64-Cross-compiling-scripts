@echo off
REM ============================================================
REM  Clean script for cross-compiled project
REM  Removes all .o and .so build artifacts
REM ============================================================

setlocal

set SRC_DIR=src
set LIB_DIR=lib

echo.
echo ===== Cleaning build artifacts =====
echo.

REM --- Delete all object files (.o) in src/ -------------------
if exist %SRC_DIR%\*.o (
    echo Removing object files from %SRC_DIR% ...
    del /Q %SRC_DIR%\*.o
) else (
    echo No object files found in %SRC_DIR%.
)

REM --- Delete all shared libraries (.so) in lib/ --------------
if exist %LIB_DIR%\*.so (
    echo Removing shared libraries from %LIB_DIR% ...
    del /Q %LIB_DIR%\*.so
) else (
    echo No shared libraries found in %LIB_DIR%.
)

echo.
echo Cleanup complete!
echo.

endlocal

pause
