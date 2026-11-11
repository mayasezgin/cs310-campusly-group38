enum EventCategory { academic, social, sports, clubs }

class Event {
  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.location,
    required this.category,
    required this.organizerName,
    this.imagePathOrUrl,
  });

  final String id;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime endAt;
  final String location;
  final EventCategory category;
  final String organizerName;
  final String? imagePathOrUrl;
}
