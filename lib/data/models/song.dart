class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String filePath;
  final String? albumArt;
  final int duration; // in seconds
  final String? lyrics;
  final DateTime addedDate;
  final int? trackNumber;
  final String? genre;
  final int? year;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.filePath,
    this.albumArt,
    required this.duration,
    this.lyrics,
    required this.addedDate,
    this.trackNumber,
    this.genre,
    this.year,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      filePath: json['filePath'] as String,
      albumArt: json['albumArt'] as String?,
      duration: json['duration'] as int,
      lyrics: json['lyrics'] as String?,
      addedDate: DateTime.parse(json['addedDate'] as String),
      trackNumber: json['trackNumber'] as int?,
      genre: json['genre'] as String?,
      year: json['year'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'filePath': filePath,
      'albumArt': albumArt,
      'duration': duration,
      'lyrics': lyrics,
      'addedDate': addedDate.toIso8601String(),
      'trackNumber': trackNumber,
      'genre': genre,
      'year': year,
    };
  }

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? filePath,
    String? albumArt,
    int? duration,
    String? lyrics,
    DateTime? addedDate,
    int? trackNumber,
    String? genre,
    int? year,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      filePath: filePath ?? this.filePath,
      albumArt: albumArt ?? this.albumArt,
      duration: duration ?? this.duration,
      lyrics: lyrics ?? this.lyrics,
      addedDate: addedDate ?? this.addedDate,
      trackNumber: trackNumber ?? this.trackNumber,
      genre: genre ?? this.genre,
      year: year ?? this.year,
    );
  }
}
