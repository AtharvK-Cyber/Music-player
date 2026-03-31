class AppConstants {
  // App Info
  static const String appName = 'Offline Music Player';
  static const String appVersion = '1.0.0';
  
  // Storage
  static const String musicFolderName = 'Music';
  static const String playlistsFolderName = 'Playlists';
  static const String downloadsFolderName = 'Downloads';
  static const String tempFolderName = 'temp';
  
  // SharedPreferences Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyLastPlayedSong = 'last_played_song';
  static const String keyQueue = 'queue';
  static const String keyShuffleMode = 'shuffle_mode';
  static const String keyRepeatMode = 'repeat_mode';
  static const String keyVolume = 'volume';
  static const String keyPlaybackSpeed = 'playback_speed';
  
  // Database
  static const String dbName = 'music_player.db';
  static const int dbVersion = 1;
  
  // Audio Settings
  static const double defaultVolume = 1.0;
  static const double defaultPlaybackSpeed = 1.0;
  static const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  
  // Download Settings
  static const int maxConcurrentDownloads = 3;
  static const String defaultAudioQuality = '320kbps';
  
  // UI
  static const int itemsPerPage = 50;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  
  // Playlist Sources
  static const String sourceSpotify = 'spotify';
  static const String sourceAppleMusic = 'apple_music';
  static const String sourceYouTubeMusic = 'youtube_music';
  static const String sourceLocal = 'local';
  
  // URL Patterns
  static final RegExp spotifyPlaylistPattern = RegExp(
    r'(?:https?://)?(?:open\.)?spotify\.com/playlist/([a-zA-Z0-9]+)',
  );
  static final RegExp appleMusicPlaylistPattern = RegExp(
    r'(?:https?://)?music\.apple\.com/[a-z]{2}/playlist/[^/]+/pl\.([a-zA-Z0-9]+)',
  );
  static final RegExp youtubeMusicPlaylistPattern = RegExp(
    r'(?:https?://)?music\.youtube\.com/playlist\?list=([a-zA-Z0-9_-]+)',
  );
}
