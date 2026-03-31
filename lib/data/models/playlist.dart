class Playlist {
  final String id;
  final String name;
  final String? description;
  final List<String> songIds;
  final String? coverImage;
  final DateTime createdDate;
  final DateTime lastModified;
  final String? source; // 'spotify', 'apple_music', 'youtube_music', 'local'
  final String? sourceUrl;

  Playlist({
    required this.id,
    required this.name,
    this.description,
    required this.songIds,
    this.coverImage,
    required this.createdDate,
    required this.lastModified,
    this.source,
    this.sourceUrl,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      songIds: (json['songIds'] as List<dynamic>).map((e) => e as String).toList(),
      coverImage: json['coverImage'] as String?,
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModified: DateTime.parse(json['lastModified'] as String),
      source: json['source'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'songIds': songIds,
      'coverImage': coverImage,
      'createdDate': createdDate.toIso8601String(),
      'lastModified': lastModified.toIso8601String(),
      'source': source,
      'sourceUrl': sourceUrl,
    };
  }

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? songIds,
    String? coverImage,
    DateTime? createdDate,
    DateTime? lastModified,
    String? source,
    String? sourceUrl,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      songIds: songIds ?? this.songIds,
      coverImage: coverImage ?? this.coverImage,
      createdDate: createdDate ?? this.createdDate,
      lastModified: lastModified ?? this.lastModified,
      source: source ?? this.source,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  int get songCount => songIds.length;
}
