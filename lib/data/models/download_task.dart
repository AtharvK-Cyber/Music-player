enum DownloadStatus {
  pending,
  downloading,
  completed,
  failed,
  paused,
}

class DownloadTask {
  final String id;
  final String title;
  final String artist;
  final String url;
  final String destinationPath;
  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final int? totalBytes;
  final int? downloadedBytes;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? completedAt;

  DownloadTask({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
    required this.destinationPath,
    required this.status,
    this.progress = 0.0,
    this.totalBytes,
    this.downloadedBytes,
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
  });

  factory DownloadTask.fromJson(Map<String, dynamic> json) {
    return DownloadTask(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      url: json['url'] as String,
      destinationPath: json['destinationPath'] as String,
      status: DownloadStatus.values.firstWhere(
        (e) => e.toString() == 'DownloadStatus.${json['status']}',
        orElse: () => DownloadStatus.pending,
      ),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      totalBytes: json['totalBytes'] as int?,
      downloadedBytes: json['downloadedBytes'] as int?,
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'url': url,
      'destinationPath': destinationPath,
      'status': status.toString().split('.').last,
      'progress': progress,
      'totalBytes': totalBytes,
      'downloadedBytes': downloadedBytes,
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  DownloadTask copyWith({
    String? id,
    String? title,
    String? artist,
    String? url,
    String? destinationPath,
    DownloadStatus? status,
    double? progress,
    int? totalBytes,
    int? downloadedBytes,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return DownloadTask(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      url: url ?? this.url,
      destinationPath: destinationPath ?? this.destinationPath,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      totalBytes: totalBytes ?? this.totalBytes,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  bool get isCompleted => status == DownloadStatus.completed;
  bool get isFailed => status == DownloadStatus.failed;
  bool get isDownloading => status == DownloadStatus.downloading;
  bool get isPending => status == DownloadStatus.pending;
  bool get isPaused => status == DownloadStatus.paused;
}
