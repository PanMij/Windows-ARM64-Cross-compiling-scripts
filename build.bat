@echo off
REM ============================================================
REM  Cross-compilation script for ARM GNU Toolchain
REM  This script builds all .c files in src/ into a shared lib
REM  Output: lib\libcalc.so
REM ============================================================

setlocal

REM --- Paths --------------------------------------------------
set TOOLCHAIN=arm-gnu-toolchain-14.3.rel1-mingw-w64-x86_64-aarch64-none-linux-gnu
set CC=%TOOLCHAIN%\bin\aarch64-none-linux-gnu-gcc.exe
set SRC_DIR=src
set INCLUDE_DIR=include
set LIB_DIR=lib
set LIB_NAME=test

REM --- Compilation flags --------------------------------------
set CFLAGS=-fPIC -I%INCLUDE_DIR%
set LDFLAGS=-shared

echo.
echo ===== Building shared library: libcalc.so =====
echo.

REM --- Create output directory if not exists ------------------
if not exist %LIB_DIR% mkdir %LIB_DIR%

REM --- Compile all .c files in src/ ----------------------------
for %%f in (%SRC_DIR%\*.c) do (
    echo Compiling %%f ...
    "%CC%" %CFLAGS% -c "%%f" -o "%%~dpnf.o"
    if errorlevel 1 (
        echo Failed to compile %%f
        exit /b 1
    )
)

REM --- Collect all object files -------------------------------
set OBJS=
for %%f in (%SRC_DIR%\*.o) do set OBJS=!OBJS! %%f

REM --- Enable delayed expansion for OBJS variable -------------
setlocal enabledelayedexpansion

REM --- Link all .o files into a shared library ----------------
echo Linking objects into %LIB_DIR%\lib%LIB_NAME%.so ...
"%CC%" %LDFLAGS% -o "%LIB_DIR%\lib%LIB_NAME%.so" %SRC_DIR%\*.o
if errorlevel 1 (
    echo Linking failed.
    exit /b 1
)

echo.
echo Build successful!
echo Output: %LIB_DIR%\lib%LIB_NAME%.so
echo.

endlocal

pause
