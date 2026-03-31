import 'package:flutter/material.dart';
import '../data/models/song.dart';

enum PlayerState {
  stopped,
  playing,
  paused,
  loading,
}

enum RepeatMode {
  off,
  all,
  one,
}

class PlayerProvider extends ChangeNotifier {
  PlayerState _playerState = PlayerState.stopped;
  Song? _currentSong;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isShuffleEnabled = false;
  RepeatMode _repeatMode = RepeatMode.off;
  double _volume = 1.0;
  double _playbackSpeed = 1.0;

  PlayerState get playerState => _playerState;
  Song? get currentSong => _currentSong;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  bool get isShuffleEnabled => _isShuffleEnabled;
  RepeatMode get repeatMode => _repeatMode;
  double get volume => _volume;
  double get playbackSpeed => _playbackSpeed;

  bool get isPlaying => _playerState == PlayerState.playing;
  bool get isPaused => _playerState == PlayerState.paused;
  bool get isStopped => _playerState == PlayerState.stopped;
  bool get isLoading => _playerState == PlayerState.loading;

  double get progress {
    if (_totalDuration.inMilliseconds == 0) return 0.0;
    return _currentPosition.inMilliseconds / _totalDuration.inMilliseconds;
  }

  void setPlayerState(PlayerState state) {
    _playerState = state;
    notifyListeners();
  }

  void setCurrentSong(Song? song) {
    _currentSong = song;
    _currentPosition = Duration.zero;
    notifyListeners();
  }

  void setCurrentPosition(Duration position) {
    _currentPosition = position;
    notifyListeners();
  }

  void setTotalDuration(Duration duration) {
    _totalDuration = duration;
    notifyListeners();
  }

  void play() {
    _playerState = PlayerState.playing;
    notifyListeners();
  }

  void pause() {
    _playerState = PlayerState.paused;
    notifyListeners();
  }

  void stop() {
    _playerState = PlayerState.stopped;
    _currentPosition = Duration.zero;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_playerState == PlayerState.playing) {
      pause();
    } else {
      play();
    }
  }

  void toggleShuffle() {
    _isShuffleEnabled = !_isShuffleEnabled;
    notifyListeners();
  }

  void toggleRepeat() {
    switch (_repeatMode) {
      case RepeatMode.off:
        _repeatMode = RepeatMode.all;
        break;
      case RepeatMode.all:
        _repeatMode = RepeatMode.one;
        break;
      case RepeatMode.one:
        _repeatMode = RepeatMode.off;
        break;
    }
    notifyListeners();
  }

  void setVolume(double value) {
    _volume = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setPlaybackSpeed(double speed) {
    _playbackSpeed = speed;
    notifyListeners();
  }

  void seek(Duration position) {
    _currentPosition = position;
    notifyListeners();
  }

  void seekToPercentage(double percentage) {
    final position = Duration(
      milliseconds: (_totalDuration.inMilliseconds * percentage).round(),
    );
    seek(position);
  }
}
