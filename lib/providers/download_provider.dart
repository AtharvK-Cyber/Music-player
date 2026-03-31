import 'package:flutter/material.dart';
import '../data/models/download_task.dart';

class DownloadProvider extends ChangeNotifier {
  final List<DownloadTask> _downloadTasks = [];
  final Map<String, DownloadTask> _taskMap = {};

  List<DownloadTask> get downloadTasks => List.unmodifiable(_downloadTasks);
  
  List<DownloadTask> get activeDownloads => _downloadTasks
      .where((task) => task.isDownloading || task.isPending)
      .toList();
      
  List<DownloadTask> get completedDownloads => _downloadTasks
      .where((task) => task.isCompleted)
      .toList();
      
  List<DownloadTask> get failedDownloads => _downloadTasks
      .where((task) => task.isFailed)
      .toList();

  int get activeDownloadCount => activeDownloads.length;
  int get completedDownloadCount => completedDownloads.length;
  int get failedDownloadCount => failedDownloads.length;

  void addDownloadTask(DownloadTask task) {
    _downloadTasks.add(task);
    _taskMap[task.id] = task;
    notifyListeners();
  }

  void updateDownloadTask(DownloadTask updatedTask) {
    final index = _downloadTasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _downloadTasks[index] = updatedTask;
      _taskMap[updatedTask.id] = updatedTask;
      notifyListeners();
    }
  }

  void updateTaskProgress(String taskId, double progress, {int? downloadedBytes, int? totalBytes}) {
    final task = _taskMap[taskId];
    if (task != null) {
      final updatedTask = task.copyWith(
        progress: progress,
        downloadedBytes: downloadedBytes ?? task.downloadedBytes,
        totalBytes: totalBytes ?? task.totalBytes,
        status: progress >= 1.0 ? DownloadStatus.completed : DownloadStatus.downloading,
        completedAt: progress >= 1.0 ? DateTime.now() : null,
      );
      updateDownloadTask(updatedTask);
    }
  }

  void updateTaskStatus(String taskId, DownloadStatus status, {String? errorMessage}) {
    final task = _taskMap[taskId];
    if (task != null) {
      final updatedTask = task.copyWith(
        status: status,
        errorMessage: errorMessage,
        completedAt: status == DownloadStatus.completed ? DateTime.now() : null,
      );
      updateDownloadTask(updatedTask);
    }
  }

  void removeDownloadTask(String taskId) {
    _downloadTasks.removeWhere((task) => task.id == taskId);
    _taskMap.remove(taskId);
    notifyListeners();
  }

  void clearCompletedDownloads() {
    _downloadTasks.removeWhere((task) => task.isCompleted);
    _taskMap.removeWhere((key, task) => task.isCompleted);
    notifyListeners();
  }

  void clearFailedDownloads() {
    _downloadTasks.removeWhere((task) => task.isFailed);
    _taskMap.removeWhere((key, task) => task.isFailed);
    notifyListeners();
  }

  void retryFailedDownload(String taskId) {
    final task = _taskMap[taskId];
    if (task != null && task.isFailed) {
      final updatedTask = task.copyWith(
        status: DownloadStatus.pending,
        progress: 0.0,
        errorMessage: null,
      );
      updateDownloadTask(updatedTask);
    }
  }

  DownloadTask? getTask(String taskId) {
    return _taskMap[taskId];
  }

  bool isDownloading(String taskId) {
    final task = _taskMap[taskId];
    return task != null && task.isDownloading;
  }
}
