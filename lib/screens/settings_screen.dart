import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/performance_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final performanceProvider = context.watch<PerformanceProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Appearance', style: TextStyle(fontWeight: FontWeight.bold)),
            leading: Icon(Icons.palette_outlined),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(themeProvider.isSystemMode ? 'Using system' : 'Manual'),
            value: themeProvider.isDarkMode,
            onChanged: (v) => themeProvider.setThemeMode(v ? ThemeMode.dark : ThemeMode.light),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          const Divider(),
          const ListTile(
            title: Text('Performance (OnePlus Nord)', style: TextStyle(fontWeight: FontWeight.bold)),
            leading: Icon(Icons.speed),
          ),
          SwitchListTile(
            title: const Text('High Performance (90Hz)'),
            subtitle: const Text('Smooth scrolling, more battery'),
            value: performanceProvider.highPerformanceMode,
            onChanged: (v) => performanceProvider.setHighPerformanceMode(v),
            secondary: const Icon(Icons.bolt),
          ),
          SwitchListTile(
            title: const Text('Battery Optimization'),
            subtitle: const Text('Reduce animations when low battery'),
            value: performanceProvider.batteryOptimizationEnabled,
            onChanged: (v) => performanceProvider.setBatteryOptimization(v),
            secondary: const Icon(Icons.battery_saver),
          ),
          const Divider(),
          ListTile(
            title: const Text('OnePlus Nord Optimizations'),
            subtitle: const Text('✓ 90Hz • ✓ Battery • ✓ Memory • ✓ UI'),
            leading: const Icon(Icons.verified, color: Colors.green),
            onTap: () => _showInfo(context),
          ),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Optimizations Active'),
        content: Text('✅ 90Hz Display\n✅ Battery Saver\n✅ Memory < 200MB\n✅ Image Caching'),
      ),
    );
  }
}
