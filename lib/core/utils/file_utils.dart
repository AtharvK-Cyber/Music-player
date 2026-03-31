import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';

class FileUtils {
  static Future<Directory> getMusicDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final musicDir = Directory(path.join(appDir.path, AppConstants.musicFolderName));
    
    if (!await musicDir.exists()) {
      await musicDir.create(recursive: true);
    }
    
    return musicDir;
  }

  static Future<Directory> getPlaylistsDirectory() async {
    final musicDir = await getMusicDirectory();
    final playlistsDir = Directory(
      path.join(musicDir.path, AppConstants.playlistsFolderName),
    );
    
    if (!await playlistsDir.exists()) {
      await playlistsDir.create(recursive: true);
    }
    
    return playlistsDir;
  }

  static Future<Directory> getDownloadsDirectory() async {
    final musicDir = await getMusicDirectory();
    final downloadsDir = Directory(
      path.join(musicDir.path, AppConstants.downloadsFolderName),
    );
    
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }
    
    return downloadsDir;
  }

  static Future<Directory> createPlaylistDirectory(String playlistName) async {
    final playlistsDir = await getPlaylistsDirectory();
    final sanitizedName = sanitizeFileName(playlistName);
    final playlistDir = Directory(path.join(playlistsDir.path, sanitizedName));
    
    if (!await playlistDir.exists()) {
      await playlistDir.create(recursive: true);
    }
    
    return playlistDir;
  }

  static String sanitizeFileName(String fileName) {
    // Remove invalid characters for file names
    return fileName
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .trim();
  }

  static String generateFileName(String artist, String title, {String extension = 'mp3'}) {
    final sanitizedArtist = sanitizeFileName(artist);
    final sanitizedTitle = sanitizeFileName(title);
    return '$sanitizedArtist - $sanitizedTitle.$extension';
  }

  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  static Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  static String getFileExtension(String filePath) {
    return path.extension(filePath);
  }

  static String getFileName(String filePath) {
    return path.basename(filePath);
  }

  static Future<List<FileSystemEntity>> listFilesInDirectory(
    Directory directory, {
    List<String> extensions = const ['.mp3', '.m4a', '.aac', '.flac'],
  }) async {
    if (!await directory.exists()) {
      return [];
    }

    final files = <FileSystemEntity>[];
    await for (var entity in directory.list()) {
      if (entity is File) {
        final ext = path.extension(entity.path).toLowerCase();
        if (extensions.contains(ext)) {
          files.add(entity);
        }
      }
    }

    return files;
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
