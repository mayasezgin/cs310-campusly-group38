import 'package:flutter/foundation.dart';

class SavedEvents extends ChangeNotifier {
  final Set<String> _savedIds = {};

  bool isSaved(String eventId) => _savedIds.contains(eventId);

  void save(String eventId) {
    if (_savedIds.add(eventId)) {
      notifyListeners();
    }
  }

  void unsave(String eventId) {
    if (_savedIds.remove(eventId)) {
      notifyListeners();
    }
  }
}
