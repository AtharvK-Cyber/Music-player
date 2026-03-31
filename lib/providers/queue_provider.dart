import 'package:flutter/material.dart';
import '../data/models/song.dart';
import '../data/models/queue_item.dart';

class QueueProvider extends ChangeNotifier {
  final List<QueueItem> _queue = [];
  int _currentIndex = -1;

  List<QueueItem> get queue => List.unmodifiable(_queue);
  int get currentIndex => _currentIndex;
  QueueItem? get currentItem => _currentIndex >= 0 && _currentIndex < _queue.length
      ? _queue[_currentIndex]
      : null;

  bool get hasNext => _currentIndex < _queue.length - 1;
  bool get hasPrevious => _currentIndex > 0;
  bool get isEmpty => _queue.isEmpty;
  int get length => _queue.length;

  void setQueue(List<Song> songs, {int startIndex = 0}) {
    _queue.clear();
    for (var i = 0; i < songs.length; i++) {
      _queue.add(QueueItem(
        id: 'queue_${DateTime.now().millisecondsSinceEpoch}_$i',
        songId: songs[i].id,
        position: i,
      ));
    }
    _currentIndex = startIndex;
    notifyListeners();
  }

  void addToQueue(Song song) {
    _queue.add(QueueItem(
      id: 'queue_${DateTime.now().millisecondsSinceEpoch}',
      songId: song.id,
      position: _queue.length,
    ));
    notifyListeners();
  }

  void addNextToQueue(Song song) {
    final insertIndex = _currentIndex + 1;
    _queue.insert(insertIndex, QueueItem(
      id: 'queue_${DateTime.now().millisecondsSinceEpoch}',
      songId: song.id,
      position: insertIndex,
    ));
    _reindexQueue();
    notifyListeners();
  }

  void removeFromQueue(int index) {
    if (index < 0 || index >= _queue.length) return;
    
    _queue.removeAt(index);
    if (index < _currentIndex) {
      _currentIndex--;
    } else if (index == _currentIndex && _currentIndex >= _queue.length) {
      _currentIndex = _queue.length - 1;
    }
    _reindexQueue();
    notifyListeners();
  }

  void moveQueueItem(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _queue.length ||
        newIndex < 0 || newIndex >= _queue.length) {
      return;
    }

    final item = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, item);

    if (oldIndex == _currentIndex) {
      _currentIndex = newIndex;
    } else if (oldIndex < _currentIndex && newIndex >= _currentIndex) {
      _currentIndex--;
    } else if (oldIndex > _currentIndex && newIndex <= _currentIndex) {
      _currentIndex++;
    }

    _reindexQueue();
    notifyListeners();
  }

  void next() {
    if (hasNext) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (hasPrevious) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void jumpTo(int index) {
    if (index >= 0 && index < _queue.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void shuffle() {
    if (_queue.isEmpty) return;

    final currentItem = this.currentItem;
    _queue.shuffle();
    
    if (currentItem != null) {
      final newIndex = _queue.indexWhere((item) => item.id == currentItem.id);
      if (newIndex != -1) {
        _currentIndex = newIndex;
      }
    }

    _reindexQueue();
    notifyListeners();
  }

  void clear() {
    _queue.clear();
    _currentIndex = -1;
    notifyListeners();
  }

  void _reindexQueue() {
    for (var i = 0; i < _queue.length; i++) {
      final item = _queue[i];
      _queue[i] = QueueItem(
        id: item.id,
        songId: item.songId,
        position: i,
      );
    }
  }

  List<String> getSongIds() {
    return _queue.map((item) => item.songId).toList();
  }
}
