import os
import pathlib

# Base directory
base_dir = pathlib.Path(__file__).parent

# Directory structure
directories = [
    # Lib directories
    'lib',
    'lib/core/constants',
    'lib/core/themes',
    'lib/core/utils',
    'lib/data/models',
    'lib/data/repositories',
    'lib/data/services',
    'lib/providers',
    'lib/screens/home',
    'lib/screens/player',
    'lib/screens/library',
    'lib/screens/downloads',
    'lib/screens/search',
    'lib/screens/paste_link',
    'lib/widgets',
    
    # Android directories
    'android/app/src/main/kotlin/com/example/offline_music_player',
    'android/app/src/main/res/drawable',
    'android/app/src/main/res/mipmap-hdpi',
    'android/app/src/main/res/mipmap-mdpi',
    'android/app/src/main/res/mipmap-xhdpi',
    'android/app/src/main/res/mipmap-xxhdpi',
    'android/app/src/main/res/mipmap-xxxhdpi',
    'android/app/src/main/res/values',
    'android/app/src/main/res/xml',
    'android/gradle/wrapper',
    
    # iOS directories
    'ios/Runner/Assets.xcassets',
    'ios/Runner/Base.lproj',
    
    # Assets
    'assets/images',
    'assets/icons',
    'assets/fonts',
    
    # Test
    'test',
]

print("Creating Flutter project directory structure...")

for directory in directories:
    dir_path = base_dir / directory
    dir_path.mkdir(parents=True, exist_ok=True)
    print(f"Created: {directory}")

print("\n✓ Directory structure created successfully!")
print("Next step: Run 'flutter pub get' to install dependencies")
