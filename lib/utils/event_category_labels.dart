import '../models/event.dart';

/// Human-readable name for an [EventCategory], e.g. "Academic".
String categoryLabel(EventCategory category) => switch (category) {
  EventCategory.academic => 'Academic',
  EventCategory.social => 'Social',
  EventCategory.sports => 'Sports',
  EventCategory.clubs => 'Clubs',
};
