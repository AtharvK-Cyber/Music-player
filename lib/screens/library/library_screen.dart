import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Songs'),
              Tab(text: 'Albums'),
              Tab(text: 'Artists'),
              Tab(text: 'Playlists'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SongsTab(),
            AlbumsTab(),
            ArtistsTab(),
            PlaylistsTab(),
          ],
        ),
      ),
    );
  }
}

class SongsTab extends StatelessWidget {
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final songs = library.songs;

    if (songs.isEmpty) {
      return const Center(child: Text('No songs in library'));
    }

    return ListView.builder(
      itemCount: songs.length,
      physics: const BouncingScrollPhysics(), // Smoother scrolling on OnePlus
      cacheExtent: 500, // Better performance for 90Hz display
      itemBuilder: (context, index) {
        final song = songs[index];
        return RepaintBoundary( // Optimize rendering
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: song.albumArt != null ? NetworkImage(song.albumArt!) : null,
              child: song.albumArt == null ? const Icon(Icons.music_note) : null,
            ),
            title: Text(song.title),
            subtitle: Text(song.artist),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            onTap: () {
              // TODO: Play song
            },
          ),
        );
      },
    );
  }
}

class AlbumsTab extends StatelessWidget {
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final albums = library.albums;

    if (albums.isEmpty) {
      return const Center(child: Text('No albums in library'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(), // Smoother scrolling
      cacheExtent: 500, // Better caching for OnePlus Nord
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return RepaintBoundary( // Prevent unnecessary repaints
          child: Card(
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: album.coverImage != null
                        ? Image.network(
                            album.coverImage!,
                            fit: BoxFit.cover,
                            cacheWidth: 400, // Optimize memory usage
                            cacheHeight: 400,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                child: const Center(
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.album, size: 48),
                          ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album.name,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        album.artist,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ArtistsTab extends StatelessWidget {
  const ArtistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final artists = library.artists;

    if (artists.isEmpty) {
      return const Center(child: Text('No artists in library'));
    }

    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: artist.imageUrl != null ? NetworkImage(artist.imageUrl!) : null,
            child: artist.imageUrl == null ? const Icon(Icons.person) : null,
          ),
          title: Text(artist.name),
          subtitle: Text('${artist.songCount} songs • ${artist.albumCount} albums'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }
}

class PlaylistsTab extends StatelessWidget {
  const PlaylistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final playlists = library.playlists;

    if (playlists.isEmpty) {
      return const Center(child: Text('No playlists yet'));
    }

    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return ListTile(
          leading: playlist.coverImage != null
              ? Image.network(playlist.coverImage!, width: 56, height: 56, fit: BoxFit.cover)
              : Container(
                  width: 56,
                  height: 56,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.playlist_play),
                ),
          title: Text(playlist.name),
          subtitle: Text('${playlist.songCount} songs'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }
}
