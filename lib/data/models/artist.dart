class Artist {
  final String id;
  final String name;
  final String? imageUrl;
  final List<String> songIds;
  final List<String> albumIds;

  Artist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.songIds,
    required this.albumIds,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      songIds: (json['songIds'] as List<dynamic>).map((e) => e as String).toList(),
      albumIds: (json['albumIds'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'songIds': songIds,
      'albumIds': albumIds,
    };
  }

  int get songCount => songIds.length;
  int get albumCount => albumIds.length;
}
