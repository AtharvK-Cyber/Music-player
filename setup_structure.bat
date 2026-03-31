@echo off
echo ========================================
echo Flutter Project Setup
echo ========================================
echo.

if not exist lib mkdir lib 2>nul
if not exist lib\core mkdir lib\core 2>nul
if not exist lib\core\constants mkdir lib\core\constants 2>nul
if not exist lib\core\themes mkdir lib\core\themes 2>nul
if not exist lib\core\utils mkdir lib\core\utils 2>nul
if not exist lib\data mkdir lib\data 2>nul
if not exist lib\data\models mkdir lib\data\models 2>nul
if not exist lib\data\repositories mkdir lib\data\repositories 2>nul
if not exist lib\data\services mkdir lib\data\services 2>nul
if not exist lib\providers mkdir lib\providers 2>nul
if not exist lib\screens mkdir lib\screens 2>nul
if not exist lib\screens\home mkdir lib\screens\home 2>nul
if not exist lib\screens\player mkdir lib\screens\player 2>nul
if not exist lib\screens\library mkdir lib\screens\library 2>nul
if not exist lib\screens\downloads mkdir lib\screens\downloads 2>nul
if not exist lib\screens\search mkdir lib\screens\search 2>nul
if not exist lib\screens\paste_link mkdir lib\screens\paste_link 2>nul
if not exist lib\widgets mkdir lib\widgets 2>nul

if not exist android mkdir android 2>nul
if not exist android\app mkdir android\app 2>nul
if not exist android\app\src mkdir android\app\src 2>nul
if not exist android\app\src\main mkdir android\app\src\main 2>nul
if not exist android\app\src\main\kotlin\com\example\offline_music_player mkdir android\app\src\main\kotlin\com\example\offline_music_player 2>nul
if not exist android\app\src\main\res mkdir android\app\src\main\res 2>nul
if not exist android\app\src\main\res\drawable mkdir android\app\src\main\res\drawable 2>nul
if not exist android\app\src\main\res\mipmap-hdpi mkdir android\app\src\main\res\mipmap-hdpi 2>nul
if not exist android\app\src\main\res\mipmap-mdpi mkdir android\app\src\main\res\mipmap-mdpi 2>nul
if not exist android\app\src\main\res\mipmap-xhdpi mkdir android\app\src\main\res\mipmap-xhdpi 2>nul
if not exist android\app\src\main\res\mipmap-xxhdpi mkdir android\app\src\main\res\mipmap-xxhdpi 2>nul
if not exist android\app\src\main\res\mipmap-xxxhdpi mkdir android\app\src\main\res\mipmap-xxxhdpi 2>nul
if not exist android\app\src\main\res\values mkdir android\app\src\main\res\values 2>nul
if not exist android\app\src\main\res\xml mkdir android\app\src\main\res\xml 2>nul
if not exist android\gradle\wrapper mkdir android\gradle\wrapper 2>nul

if not exist ios mkdir ios 2>nul
if not exist ios\Runner mkdir ios\Runner 2>nul
if not exist ios\Runner\Assets.xcassets mkdir ios\Runner\Assets.xcassets 2>nul
if not exist ios\Runner\Base.lproj mkdir ios\Runner\Base.lproj 2>nul

if not exist assets mkdir assets 2>nul
if not exist assets\images mkdir assets\images 2>nul
if not exist assets\icons mkdir assets\icons 2>nul
if not exist assets\fonts mkdir assets\fonts 2>nul

if not exist test mkdir test 2>nul

echo.
echo ✓ Directory structure created successfully!
echo.
echo Next steps:
echo   1. Verify directories were created
echo   2. AI will create all source files
echo   3. Run: flutter pub get
echo.
pause
