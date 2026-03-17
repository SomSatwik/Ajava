@echo off
REM Hotel Management System - Build and Run Script for Windows

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║     HOTEL MANAGEMENT SYSTEM - BUILD AND RUN SCRIPT         ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Set paths
set JAVA_SRC=src
set LIB_DIR=lib
set MYSQL_JAR=mysql-connector-java-8.0.33.jar

REM Check if MySQL driver exists
if not exist "%LIB_DIR%\%MYSQL_JAR%" (
    echo.
    echo ✗ ERROR: MySQL JDBC driver not found!
    echo.
    echo Please download mysql-connector-java from:
    echo https://dev.mysql.com/downloads/connector/j/
    echo.
    echo Extract and place the JAR file in the 'lib' folder
    echo.
    pause
    exit /b 1
)

echo ✓ MySQL JDBC Driver found
echo.

REM Compile
echo Compiling Java files...
javac -cp "%LIB_DIR%\%MYSQL_JAR%" "%JAVA_SRC%\*.java" -d "%JAVA_SRC%"

if errorlevel 1 (
    echo.
    echo ✗ Compilation failed!
    echo.
    pause
    exit /b 1
)

echo ✓ Compilation successful!
echo.

REM Run
echo Starting Hotel Management Application...
echo.
java -cp "%LIB_DIR%\%MYSQL_JAR%;%JAVA_SRC%" HotelManagementApp

pause
