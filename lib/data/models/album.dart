class Album {
  final String id;
  final String name;
  final String artist;
  final String? coverImage;
  final int? year;
  final List<String> songIds;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    this.coverImage,
    this.year,
    required this.songIds,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      coverImage: json['coverImage'] as String?,
      year: json['year'] as int?,
      songIds: (json['songIds'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'coverImage': coverImage,
      'year': year,
      'songIds': songIds,
    };
  }

  int get songCount => songIds.length;
}
