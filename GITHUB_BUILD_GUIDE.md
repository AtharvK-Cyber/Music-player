# GitHub Actions Setup - Build APK Without Installing Flutter!

## 📋 **Step-by-Step Instructions**

### **Step 1: Create a GitHub Account** (if you don't have one)
1. Go to: https://github.com/signup
2. Create free account
3. Verify your email

---

### **Step 2: Create Required Directories**

Create these folders in your project:
```
G:\Work\Music player\.github\workflows\
```

**How:**
1. Open `G:\Work\Music player`
2. Create new folder: `.github`
3. Inside `.github`, create folder: `workflows`

---

### **Step 3: Create GitHub Actions Workflow File**

Create file: `.github\workflows\build-apk.yml`

**Copy this content:**

```yaml
name: Build Android APK

on:
  push:
    branches: [ main, master ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Java
      uses: actions/setup-java@v3
      with:
        distribution: 'zulu'
        java-version: '17'
        
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
        channel: 'stable'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Build APK
      run: flutter build apk --split-per-abi --release
      
    - name: Upload APK (OnePlus Nord)
      uses: actions/upload-artifact@v3
      with:
        name: app-arm64-v8a-release
        path: build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

---

### **Step 4: Upload to GitHub**

#### **Option A: Using GitHub Desktop (Easier)**

1. **Download GitHub Desktop:**
   - https://desktop.github.com/
   - Install it

2. **Create Repository:**
   - Open GitHub Desktop
   - Click "Create New Repository"
   - Name: `music-player-oneplus`
   - Local Path: `G:\Work\Music player`
   - Click "Create Repository"

3. **Publish to GitHub:**
   - Click "Publish repository"
   - Uncheck "Keep this code private" (or keep private, up to you)
   - Click "Publish"

4. **Push Changes:**
   - GitHub Desktop will show all your files
   - Add commit message: "Initial commit"
   - Click "Commit to main"
   - Click "Push origin"

#### **Option B: Using Git Command Line**

```cmd
cd "G:\Work\Music player"
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/music-player-oneplus.git
git push -u origin main
```

---

### **Step 5: Trigger Build**

1. **Go to your repository on GitHub:**
   - https://github.com/YOUR_USERNAME/music-player-oneplus

2. **Click "Actions" tab**

3. **Click "Build Android APK" workflow**

4. **Click "Run workflow" → "Run workflow"**

5. **Wait 5-10 minutes** (GitHub builds it for free!)

---

### **Step 6: Download Your APK!**

1. **After build completes:**
   - Go to the completed workflow
   - Scroll down to "Artifacts"
   - Click "app-arm64-v8a-release" to download

2. **Unzip the downloaded file**

3. **Copy APK to OnePlus Nord**

4. **Install!**

---

## 🎯 **Summary:**

1. ✓ Create `.github\workflows` folders
2. ✓ Create `build-apk.yml` file (copy content above)
3. ✓ Upload project to GitHub
4. ✓ Run workflow on GitHub
5. ✓ Download APK from "Artifacts"
6. ✓ Install on OnePlus Nord

**No Flutter installation needed!** ✨

---

## ⚡ **Even Faster Alternative - Codemagic**

If GitHub seems complicated:

1. Go to: https://codemagic.io/start/
2. Sign up (free)
3. Connect your repository or upload ZIP
4. Click "Build"
5. Download APK
6. Done!

---

## 🆘 **Need Help?**

**Easiest path:**
1. Download GitHub Desktop
2. Create repo from your folder
3. Publish to GitHub
4. Create the workflow file
5. Push changes
6. Run workflow
7. Download APK

**Can't do GitHub?**
- Upload project ZIP to Codemagic.io
- Or use AppCenter.ms
- Or ask a friend with Flutter to build it

---

## 📝 **What You Need:**

- GitHub account (free)
- Upload your project
- Create 1 workflow file
- Click "Run workflow"
- Download APK

**Total time: 15-20 minutes setup + 10 minutes build**

---

**Want me to guide you through the GitHub Desktop method step-by-step?**
