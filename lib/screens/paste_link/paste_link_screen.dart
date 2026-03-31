import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/utils/url_parser.dart';

class PasteLinkScreen extends StatefulWidget {
  const PasteLinkScreen({super.key});

  @override
  State<PasteLinkScreen> createState() => _PasteLinkScreenState();
}

class _PasteLinkScreenState extends State<PasteLinkScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkClipboard();
  }

  Future<void> _checkClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      final text = clipboardData.text!;
      if (UrlParser.isValidPlaylistUrl(text)) {
        _urlController.text = text;
      }
    }
  }

  Future<void> _parsePlaylist() async {
    final url = _urlController.text.trim();
    
    if (url.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a playlist URL';
      });
      return;
    }

    if (!UrlParser.isValidPlaylistUrl(url)) {
      setState(() {
        _errorMessage = 'Invalid playlist URL. Supports Spotify, Apple Music, and YouTube Music.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final metadata = await UrlParser.parsePlaylistUrl(url);
      
      setState(() {
        _isLoading = false;
      });

      if (metadata != null && mounted) {
        _showPlaylistPreview(metadata.name, metadata.trackCount);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to parse playlist: $e';
      });
    }
  }

  void _showPlaylistPreview(String name, int trackCount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Playlist Found'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name'),
            const SizedBox(height: 8),
            Text('Tracks: $trackCount'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Start download
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Download feature coming soon!')),
              );
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Playlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paste Playlist Link',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Supports Spotify, Apple Music, and YouTube Music playlists',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'https://open.spotify.com/playlist/...',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.link),
                suffixIcon: _urlController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _urlController.clear();
                          setState(() {
                            _errorMessage = null;
                          });
                        },
                      )
                    : null,
                errorText: _errorMessage,
              ),
              maxLines: 3,
              onChanged: (_) {
                setState(() {
                  _errorMessage = null;
                });
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _parsePlaylist,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.search),
                label: Text(_isLoading ? 'Parsing...' : 'Parse Playlist'),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Supported Platforms',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildPlatformChip('Spotify', Icons.music_note),
            const SizedBox(height: 8),
            _buildPlatformChip('Apple Music', Icons.music_note),
            const SizedBox(height: 8),
            _buildPlatformChip('YouTube Music', Icons.music_video),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformChip(String name, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(name),
    );
  }
}
