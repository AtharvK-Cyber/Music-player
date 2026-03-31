class PlaylistMetadata {
  final String name;
  final String? description;
  final String? coverImageUrl;
  final int trackCount;
  final List<TrackMetadata> tracks;
  final String source; // 'spotify', 'apple_music', 'youtube_music'
  final String sourceUrl;

  PlaylistMetadata({
    required this.name,
    this.description,
    this.coverImageUrl,
    required this.trackCount,
    required this.tracks,
    required this.source,
    required this.sourceUrl,
  });

  factory PlaylistMetadata.fromJson(Map<String, dynamic> json) {
    return PlaylistMetadata(
      name: json['name'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      trackCount: json['trackCount'] as int,
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => TrackMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      source: json['source'] as String,
      sourceUrl: json['sourceUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'trackCount': trackCount,
      'tracks': tracks.map((e) => e.toJson()).toList(),
      'source': source,
      'sourceUrl': sourceUrl,
    };
  }
}

class TrackMetadata {
  final String title;
  final String artist;
  final String? album;
  final int? duration; // in seconds
  final int? trackNumber;

  TrackMetadata({
    required this.title,
    required this.artist,
    this.album,
    this.duration,
    this.trackNumber,
  });

  factory TrackMetadata.fromJson(Map<String, dynamic> json) {
    return TrackMetadata(
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String?,
      duration: json['duration'] as int?,
      trackNumber: json['trackNumber'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'trackNumber': trackNumber,
    };
  }

  String get searchQuery => '$artist - $title';
}
