import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<bool> requestAudioPermission() async {
    final status = await Permission.audio.request();
    return status.isGranted;
  }

  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted || status.isLimited;
  }

  static Future<bool> checkStoragePermission() async {
    return await Permission.storage.isGranted;
  }

  static Future<bool> checkAudioPermission() async {
    return await Permission.audio.isGranted;
  }

  static Future<bool> requestAllPermissions() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.audio,
      Permission.notification,
    ].request();

    return statuses.values.every((status) => status.isGranted || status.isLimited);
  }

  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
