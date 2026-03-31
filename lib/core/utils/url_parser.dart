import '../constants/app_constants.dart';
import '../../data/models/playlist_metadata.dart';

class UrlParser {
  static String? detectPlaylistSource(String url) {
    if (AppConstants.spotifyPlaylistPattern.hasMatch(url)) {
      return AppConstants.sourceSpotify;
    } else if (AppConstants.appleMusicPlaylistPattern.hasMatch(url)) {
      return AppConstants.sourceAppleMusic;
    } else if (AppConstants.youtubeMusicPlaylistPattern.hasMatch(url)) {
      return AppConstants.sourceYouTubeMusic;
    }
    return null;
  }

  static String? extractPlaylistId(String url, String source) {
    RegExp? pattern;
    
    switch (source) {
      case AppConstants.sourceSpotify:
        pattern = AppConstants.spotifyPlaylistPattern;
        break;
      case AppConstants.sourceAppleMusic:
        pattern = AppConstants.appleMusicPlaylistPattern;
        break;
      case AppConstants.sourceYouTubeMusic:
        pattern = AppConstants.youtubeMusicPlaylistPattern;
        break;
      default:
        return null;
    }

    final match = pattern?.firstMatch(url);
    return match?.group(1);
  }

  static bool isValidPlaylistUrl(String url) {
    return detectPlaylistSource(url) != null;
  }

  static Future<PlaylistMetadata?> parsePlaylistUrl(String url) async {
    final source = detectPlaylistSource(url);
    if (source == null) return null;

    final playlistId = extractPlaylistId(url, source);
    if (playlistId == null) return null;

    // This is a placeholder - actual implementation would fetch from APIs
    // For now, return a mock metadata
    return PlaylistMetadata(
      name: 'Sample Playlist',
      description: 'This is a sample playlist',
      coverImageUrl: null,
      trackCount: 0,
      tracks: [],
      source: source,
      sourceUrl: url,
    );
  }

  static String normalizeUrl(String url) {
    url = url.trim();
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    return url;
  }
}
