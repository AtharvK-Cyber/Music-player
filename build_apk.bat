@echo off
title Building APK for OnePlus Nord
color 0A
echo.
echo ========================================
echo   BUILDING APK FOR ONEPLUS NORD
echo ========================================
echo.

cd /d "G:\Work\Music player"

echo [Step 1/3] Installing dependencies...
echo.
flutter pub get
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install dependencies!
    echo Make sure Flutter is installed and in PATH.
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo.
echo [Step 2/3] Building release APK...
echo This will take 5-10 minutes on first build.
echo Please wait...
echo.

flutter build apk --split-per-abi --release

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Build failed!
    echo Check the error messages above.
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo.
echo [Step 3/3] Build complete!
echo.

echo APKs created:
echo.
dir /b build\app\outputs\flutter-apk\*.apk
echo.

echo ========================================
echo   BUILD SUCCESSFUL!
echo ========================================
echo.
echo Your APKs are located at:
echo G:\Work\Music player\build\app\outputs\flutter-apk\
echo.
echo For OnePlus Nord, use:
echo   app-arm64-v8a-release.apk
echo.
echo Next steps:
echo   1. Copy app-arm64-v8a-release.apk to your phone
echo   2. Install it from Files app
echo   3. Grant permissions when prompted
echo.
pause

start explorer "G:\Work\Music player\build\app\outputs\flutter-apk"
