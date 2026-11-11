import '../models/event.dart';

/// Name of the club shown on the Club Dashboard until real accounts exist.
const sampleClubName = 'Campus Sustainability Club';

/// Placeholder events posted by [sampleClubName], starting tomorrow.
List<Event> sampleClubEvents({DateTime? now}) {
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
      id: 'club-greener-campus',
      title: 'Design for a Greener Campus',
      description:
          'Brainstorm and sketch ideas that make our campus more sustainable.',
      startAt: at(1, 16),
      endAt: at(1, 18),
      location: 'Innovation Lab · Room 204',
      category: EventCategory.clubs,
      organizerName: sampleClubName,
    ),
    Event(
      id: 'club-repair-cafe',
      title: 'Campus Repair Café',
      description:
          'Bring broken items and fix them together with volunteer repairers.',
      startAt: at(6, 15),
      endAt: at(6, 17),
      location: 'Student Union · Workshop Room',
      category: EventCategory.social,
      organizerName: sampleClubName,
    ),
    Event(
      id: 'club-green-meetup',
      title: 'Green Campus Meetup',
      description: 'Meet club members and plan this term\'s green projects.',
      startAt: at(9, 10),
      endAt: at(9, 11, 30),
      location: 'North Lawn',
      category: EventCategory.clubs,
      organizerName: sampleClubName,
    ),
  ];
}
