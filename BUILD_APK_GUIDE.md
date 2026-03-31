# 📱 Build APK for OnePlus Nord - Quick Guide

## ⚠️ Important: APK Not Built Yet

The APK file doesn't exist yet - we've only created the source code. You need to **build it first**!

---

## 🚀 Quick Build Instructions

### Step 1: Install Dependencies
```cmd
cd "G:\Work\Music player"
flutter pub get
```

### Step 2: Build APK
```cmd
flutter build apk --release
```

**Wait 2-5 minutes** for the build to complete.

### Step 3: Find Your APK
After building, the APK will be located at:

```
G:\Work\Music player\build\app\outputs\flutter-apk\app-release.apk
```

---

## 📲 Install on OnePlus Nord

### Method 1: USB Transfer (Recommended)
1. Connect OnePlus Nord to PC via USB
2. Copy `app-release.apk` to phone's Download folder
3. On phone: Open **Files** app → **Downloads**
4. Tap `app-release.apk`
5. Tap **Install** (allow unknown sources if asked)

### Method 2: Direct Copy
1. Copy APK to phone's storage
2. Use file manager to find it
3. Tap to install

---

## 🔧 If Build Fails

### Error: "Flutter SDK not found"
**Solution:** Install Flutter first
```cmd
# Download Flutter from: https://flutter.dev/docs/get-started/install/windows
# Add to PATH, then run:
flutter doctor
```

### Error: "Android SDK not found"
**Solution:** Create `android\local.properties`:
```
sdk.dir=C:\\Users\\YourUsername\\AppData\\Local\\Android\\sdk
flutter.sdk=C:\\path\\to\\flutter
```

### Error: Gradle build failed
**Solution:** Clean and rebuild
```cmd
cd android
gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

---

## ⚡ Quick Build Commands

### Build Release APK (Optimized, Small Size)
```cmd
flutter build apk --release
```
**Output:** `build\app\outputs\flutter-apk\app-release.apk`

### Build Split APKs (Per Architecture - Smaller)
```cmd
flutter build apk --split-per-abi --release
```
**Output:** Multiple APKs:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM - **Use this for OnePlus Nord**)
- `app-x86_64-release.apk` (x86 64-bit)

**For OnePlus Nord:** Use `app-arm64-v8a-release.apk`

---

## 📊 Build Sizes

- **Single APK:** ~40-60 MB
- **Split APK (arm64):** ~25-35 MB (Recommended for OnePlus Nord)

---

## 🎯 Complete Build & Install Process

### Full Command Sequence:
```cmd
cd "G:\Work\Music player"
flutter pub get
flutter build apk --split-per-abi --release
```

### Find APK:
```
G:\Work\Music player\build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
```

### Transfer to Phone:
1. Connect OnePlus Nord via USB
2. Copy APK to phone
3. Install from Files app

---

## ⏱️ Build Time

- First build: **5-10 minutes**
- Subsequent builds: **2-5 minutes**

---

## ✅ After Installation

1. **Grant Permissions:**
   - Storage (for music files)
   - Notifications (for playback controls)

2. **Enable Optimizations:**
   - Open app
   - Tap Settings (⚙️)
   - Enable "High Performance Mode"

3. **Enjoy!** 🎵

---

## 🔍 Verify Installation

After install:
- App icon should appear in app drawer
- Name: "Music Player"
- OnePlus Nord optimizations active automatically

---

## 💡 Pro Tips

### Faster Builds:
```cmd
flutter build apk --release --no-tree-shake-icons
```

### Debug Build (Faster but larger):
```cmd
flutter build apk --debug
```

### Check APK Size:
```cmd
dir build\app\outputs\flutter-apk\*.apk
```

---

## 🆘 Need Help?

### No Flutter Installed?
1. Download: https://flutter.dev/docs/get-started/install/windows
2. Extract to `C:\flutter`
3. Add to PATH
4. Run: `flutter doctor`

### Can't Find APK After Build?
Check:
```
G:\Work\Music player\build\app\outputs\flutter-apk\
```

### Build Successful but No APK?
Run:
```cmd
flutter clean
flutter pub get
flutter build apk --release
```

---

## 🎯 Summary

**To get your APK:**

1. Run: `flutter build apk --release`
2. Find: `build\app\outputs\flutter-apk\app-release.apk`
3. Copy to OnePlus Nord
4. Install and enjoy!

**APK will be ready in 5-10 minutes!** ⏱️
