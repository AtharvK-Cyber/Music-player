class FormatUtils {
  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }
  }

  static String formatProgress(double progress) {
    return '${(progress * 100).toStringAsFixed(0)}%';
  }

  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  static String pluralize(int count, String singular, {String? plural}) {
    if (count == 1) return singular;
    return plural ?? '${singular}s';
  }

  static String formatSongCount(int count) {
    return '$count ${pluralize(count, 'song')}';
  }

  static String formatAlbumCount(int count) {
    return '$count ${pluralize(count, 'album')}';
  }

  static String formatArtistName(List<String> artists) {
    if (artists.isEmpty) return 'Unknown Artist';
    if (artists.length == 1) return artists[0];
    if (artists.length == 2) return '${artists[0]} & ${artists[1]}';
    return '${artists[0]} & ${artists.length - 1} others';
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static String formatSpeed(double speed) {
    if (speed == 1.0) return 'Normal';
    return '${speed.toStringAsFixed(2)}x';
  }
}
