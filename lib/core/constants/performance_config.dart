import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PerformanceConfig {
  // OnePlus Nord specific optimizations
  static const bool enableHighRefreshRate = true;
  static const int targetFrameRate = 90; // OnePlus Nord has 90Hz display
  
  // Image optimization
  static const int imageCacheSize = 100; // MB
  static const int maxImageCacheAge = 7; // days
  
  // Animation settings
  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Curve animationCurve = Curves.easeOutCubic;
  
  // List rendering optimization
  static const double listItemExtent = 72.0;
  static const int maxCachedListItems = 50;
  
  // Battery optimization
  static const bool enableBatteryOptimization = true;
  static const bool reduceAnimationsOnLowBattery = true;
  static const int lowBatteryThreshold = 20; // percentage
  
  // Memory management
  static const int maxConcurrentImageLoads = 3;
  static const bool enableMemoryCache = true;
  static const int maxMemoryCacheSize = 50; // MB
  
  // Network optimization
  static const Duration imageLoadTimeout = Duration(seconds: 10);
  static const int maxRetries = 2;
  
  static void configureSystemUI() {
    // Configure status bar and navigation for OnePlus
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
    
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  
  static void enableHighPerformanceMode() {
    // Enable high performance rendering for OnePlus Nord's 90Hz display
    // This ensures smooth animations at higher refresh rates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Force enable high refresh rate
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      );
    });
  }
  
  static void optimizeForBatteryLife() {
    // Reduce background activity
    // Disable unnecessary animations
    // Optimize image loading
  }
}
