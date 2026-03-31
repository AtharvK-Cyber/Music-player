@echo off
title Music Player - Project Status
color 0A
echo.
echo ========================================
echo   OFFLINE MUSIC PLAYER - PROJECT STATUS
echo ========================================
echo.
echo Checking project structure...
echo.

echo [ROOT FILES]
if exist pubspec.yaml (echo   ✓ pubspec.yaml) else (echo   ✗ pubspec.yaml - MISSING!)
if exist README.md (echo   ✓ README.md) else (echo   ✗ README.md)
if exist analysis_options.yaml (echo   ✓ analysis_options.yaml) else (echo   ✗ analysis_options.yaml)
echo.

echo [DIRECTORIES]
if exist lib (echo   ✓ lib/) else (echo   ✗ lib/ - Run setup_structure.bat!)
if exist lib\core (echo   ✓ lib/core/) else (echo   ✗ lib/core/)
if exist lib\data (echo   ✓ lib/data/) else (echo   ✗ lib/data/)
if exist lib\providers (echo   ✓ lib/providers/) else (echo   ✗ lib/providers/)
if exist lib\screens (echo   ✓ lib/screens/) else (echo   ✗ lib/screens/)
if exist lib\widgets (echo   ✓ lib/widgets/) else (echo   ✗ lib/widgets/)
if exist android (echo   ✓ android/) else (echo   ✗ android/)
if exist ios (echo   ✓ ios/) else (echo   ✗ ios/)
if exist assets (echo   ✓ assets/) else (echo   ✗ assets/)
if exist test (echo   ✓ test/) else (echo   ✗ test/)
echo.

echo [SOURCE FILES]
if exist lib\main.dart (echo   ✓ lib/main.dart - App is ready!) else (echo   ⏳ lib/main.dart - Waiting for creation...)
if exist android\app\src\main\AndroidManifest.xml (echo   ✓ AndroidManifest.xml) else (echo   ⏳ AndroidManifest.xml - Pending...)
if exist ios\Runner\Info.plist (echo   ✓ Info.plist) else (echo   ⏳ Info.plist - Pending...)
echo.

echo ========================================
echo.

if not exist lib (
    echo ⚠️  DIRECTORIES NOT FOUND!
    echo.
    echo Please run: setup_structure.bat
    echo Then return to the AI chat and say "done"
    echo.
) else if not exist lib\main.dart (
    echo ✓ Directories ready!
    echo ⏳ Waiting for source file generation...
    echo.
    echo Go back to the AI chat and say "done"
    echo The AI will create all ~88 source files automatically!
    echo.
) else (
    echo ✓ Project appears complete!
    echo.
    echo Next step: Run 'flutter pub get' to install dependencies
    echo Then: Run 'flutter run' to launch the app
    echo.
)

echo ========================================
echo.
pause
