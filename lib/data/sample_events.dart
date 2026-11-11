import '../models/event.dart';

/// Returns sample events starting tomorrow in the local calendar.
List<Event> sampleEvents({DateTime? now}) {
  final today = (now ?? DateTime.now()).toLocal();

  DateTime at(int daysFromToday, int hour, [int minute = 0]) => DateTime(
    today.year,
    today.month,
    today.day + daysFromToday,
    hour,
    minute,
  );

  return [
    Event(
      id: 'sample-study-skills-workshop',
      title: 'Study Skills Workshop',
      description:
          'Try practical techniques for planning and exam preparation.',
      startAt: at(1, 13),
      endAt: at(1, 14),
      location: 'Library Seminar Room',
      category: EventCategory.academic,
      organizerName: 'Academic Support Center',
    ),
    Event(
      id: 'sample-campus-game-night',
      title: 'Campus Game Night',
      description: 'Play board games and meet other students.',
      startAt: at(2, 18),
      endAt: at(2, 20),
      location: 'Student Center Lounge',
      category: EventCategory.social,
      organizerName: 'Student Council',
    ),
    Event(
      id: 'sample-pickup-basketball',
      title: 'Pickup Basketball',
      description: 'Join a casual game open to all skill levels.',
      startAt: at(3, 16),
      endAt: at(3, 17, 30),
      location: 'Sports Hall',
      category: EventCategory.sports,
      organizerName: 'Campus Recreation',
    ),
    Event(
      id: 'sample-photography-club-meetup',
      title: 'Photography Club Meetup',
      description: 'Meet the club and join a photo walk around campus.',
      startAt: at(4, 15),
      endAt: at(4, 16, 30),
      location: 'Student Center Entrance',
      category: EventCategory.clubs,
      organizerName: 'Photography Club',
    ),
  ];
}
