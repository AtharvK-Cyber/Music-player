import 'package:flutter/material.dart';
import '../data/models/song.dart';
import '../data/models/playlist.dart';
import '../data/models/album.dart';
import '../data/models/artist.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Song> _songs = [];
  final List<Playlist> _playlists = [];
  final List<Album> _albums = [];
  final List<Artist> _artists = [];

  List<Song> get songs => List.unmodifiable(_songs);
  List<Playlist> get playlists => List.unmodifiable(_playlists);
  List<Album> get albums => List.unmodifiable(_albums);
  List<Artist> get artists => List.unmodifiable(_artists);

  int get songCount => _songs.length;
  int get playlistCount => _playlists.length;
  int get albumCount => _albums.length;
  int get artistCount => _artists.length;

  // Songs
  void addSong(Song song) {
    _songs.add(song);
    _organizeLibrary();
    notifyListeners();
  }

  void addSongs(List<Song> songs) {
    _songs.addAll(songs);
    _organizeLibrary();
    notifyListeners();
  }

  void removeSong(String songId) {
    _songs.removeWhere((song) => song.id == songId);
    _organizeLibrary();
    notifyListeners();
  }

  Song? getSongById(String id) {
    try {
      return _songs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Song> getSongsByIds(List<String> ids) {
    return _songs.where((song) => ids.contains(song.id)).toList();
  }

  // Playlists
  void addPlaylist(Playlist playlist) {
    _playlists.add(playlist);
    notifyListeners();
  }

  void removePlaylist(String playlistId) {
    _playlists.removeWhere((playlist) => playlist.id == playlistId);
    notifyListeners();
  }

  void updatePlaylist(Playlist updatedPlaylist) {
    final index = _playlists.indexWhere((p) => p.id == updatedPlaylist.id);
    if (index != -1) {
      _playlists[index] = updatedPlaylist;
      notifyListeners();
    }
  }

  Playlist? getPlaylistById(String id) {
    try {
      return _playlists.firstWhere((playlist) => playlist.id == id);
    } catch (e) {
      return null;
    }
  }

  // Albums
  Album? getAlbumById(String id) {
    try {
      return _albums.firstWhere((album) => album.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Song> getSongsForAlbum(String albumId) {
    final album = getAlbumById(albumId);
    if (album == null) return [];
    return getSongsByIds(album.songIds);
  }

  // Artists
  Artist? getArtistById(String id) {
    try {
      return _artists.firstWhere((artist) => artist.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Song> getSongsForArtist(String artistId) {
    final artist = getArtistById(artistId);
    if (artist == null) return [];
    return getSongsByIds(artist.songIds);
  }

  // Search
  List<Song> searchSongs(String query) {
    final lowerQuery = query.toLowerCase();
    return _songs.where((song) {
      return song.title.toLowerCase().contains(lowerQuery) ||
          song.artist.toLowerCase().contains(lowerQuery) ||
          song.album.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Private helper to organize library
  void _organizeLibrary() {
    _organizeAlbums();
    _organizeArtists();
  }

  void _organizeAlbums() {
    final Map<String, List<Song>> albumMap = {};
    
    for (var song in _songs) {
      final albumKey = '${song.album}_${song.artist}';
      albumMap.putIfAbsent(albumKey, () => []).add(song);
    }

    _albums.clear();
    albumMap.forEach((key, songs) {
      if (songs.isNotEmpty) {
        final firstSong = songs.first;
        _albums.add(Album(
          id: key,
          name: firstSong.album,
          artist: firstSong.artist,
          coverImage: firstSong.albumArt,
          year: firstSong.year,
          songIds: songs.map((s) => s.id).toList(),
        ));
      }
    });
  }

  void _organizeArtists() {
    final Map<String, List<Song>> artistMap = {};
    
    for (var song in _songs) {
      artistMap.putIfAbsent(song.artist, () => []).add(song);
    }

    _artists.clear();
    artistMap.forEach((artistName, songs) {
      final artistAlbumIds = _albums
          .where((album) => album.artist == artistName)
          .map((album) => album.id)
          .toList();

      _artists.add(Artist(
        id: artistName,
        name: artistName,
        imageUrl: songs.first.albumArt,
        songIds: songs.map((s) => s.id).toList(),
        albumIds: artistAlbumIds,
      ));
    });
  }

  void loadLibrary(List<Song> songs, List<Playlist> playlists) {
    _songs.clear();
    _playlists.clear();
    _songs.addAll(songs);
    _playlists.addAll(playlists);
    _organizeLibrary();
    notifyListeners();
  }
}
