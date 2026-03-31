@echo off
title Quick APK Build
echo Building APK...
cd /d "G:\Work\Music player"
flutter pub get && flutter build apk --split-per-abi --release
if %errorlevel%==0 (
    echo.
    echo SUCCESS! APK is ready at:
    echo build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
    echo.
    start explorer "build\app\outputs\flutter-apk"
) else (
    echo.
    echo BUILD FAILED! Check errors above.
)
pause
