class QueueItem {
  final String id;
  final String songId;
  final int position;

  QueueItem({
    required this.id,
    required this.songId,
    required this.position,
  });

  factory QueueItem.fromJson(Map<String, dynamic> json) {
    return QueueItem(
      id: json['id'] as String,
      songId: json['songId'] as String,
      position: json['position'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songId': songId,
      'position': position,
    };
  }
}
