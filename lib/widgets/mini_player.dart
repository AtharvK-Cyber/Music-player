import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../screens/player/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.watch<PlayerProvider>();
    final song = playerProvider.currentSong;

    if (song == null) return const SizedBox.shrink();

    return RepaintBoundary( // Optimize mini player rendering
      child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlayerScreen()),
        );
      },
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: playerProvider.progress,
              minHeight: 2,
              backgroundColor: Colors.transparent,
            ),
            Expanded(
              child: Row(
                children: [
                  // Album Art
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(left: 8, right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: song.albumArt != null
                          ? Image.network(song.albumArt!, fit: BoxFit.cover)
                          : Container(
                              color: Theme.of(context).colorScheme.surfaceContainerHigh,
                              child: const Icon(Icons.music_note, size: 24),
                            ),
                    ),
                  ),
                  
                  // Song Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          song.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          song.artist,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Play/Pause Button
                  IconButton(
                    icon: Icon(
                      playerProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 32,
                    ),
                    onPressed: () => playerProvider.togglePlayPause(),
                  ),
                  
                  // Next Button
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: () {
                      // TODO: Next track
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
