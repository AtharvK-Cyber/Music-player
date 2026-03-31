import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerformanceProvider extends ChangeNotifier {
  bool _highPerformanceMode = true;
  bool _batteryOptimizationEnabled = true;
  int _batteryLevel = 100;
  bool _isLowPowerMode = false;

  bool get highPerformanceMode => _highPerformanceMode;
  bool get batteryOptimizationEnabled => _batteryOptimizationEnabled;
  int get batteryLevel => _batteryLevel;
  bool get isLowPowerMode => _isLowPowerMode;

  // Animation settings based on performance mode
  Duration get animationDuration {
    if (_isLowPowerMode) return const Duration(milliseconds: 150);
    if (!_highPerformanceMode) return const Duration(milliseconds: 200);
    return const Duration(milliseconds: 250);
  }

  bool get shouldReduceAnimations => _isLowPowerMode || (_batteryLevel < 20 && _batteryOptimizationEnabled);
  bool get shouldOptimizeImages => _batteryLevel < 30 || !_highPerformanceMode;

  PerformanceProvider() {
    _loadSettings();
    _monitorBattery();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _highPerformanceMode = prefs.getBool('high_performance_mode') ?? true;
    _batteryOptimizationEnabled = prefs.getBool('battery_optimization') ?? true;
    notifyListeners();
  }

  void _monitorBattery() {
    // In a real implementation, use battery_plus package
    // For now, this is a placeholder
    // battery.onBatteryStateChanged.listen((BatteryState state) {
    //   _updateBatteryStatus(state);
    // });
  }

  void updateBatteryLevel(int level) {
    _batteryLevel = level;
    _isLowPowerMode = level < 20 && _batteryOptimizationEnabled;
    notifyListeners();
  }

  Future<void> setHighPerformanceMode(bool enabled) async {
    _highPerformanceMode = enabled;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('high_performance_mode', enabled);
  }

  Future<void> setBatteryOptimization(bool enabled) async {
    _batteryOptimizationEnabled = enabled;
    _isLowPowerMode = _batteryLevel < 20 && enabled;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('battery_optimization', enabled);
  }

  // Get optimal image quality based on performance mode
  int getOptimalImageCacheSize() {
    if (_isLowPowerMode) return 300; // 300px for low power
    if (!_highPerformanceMode) return 500;
    return 800; // Full quality for high performance
  }

  // Check if animations should be enabled
  bool shouldEnableAnimations() {
    return !shouldReduceAnimations;
  }

  // Get optimal list cache extent
  double getOptimalCacheExtent() {
    if (_isLowPowerMode) return 250;
    if (!_highPerformanceMode) return 400;
    return 500; // Maximum for smooth 90Hz scrolling
  }
}
