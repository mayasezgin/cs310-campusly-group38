import 'package:flutter/material.dart';

import '../models/event.dart';
import '../state/saved_events.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({
    super.key,
    required this.events,
    required this.savedEvents,
  });

  final List<Event> events;
  final SavedEvents savedEvents;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: savedEvents,
      builder: (context, child) {
        return ListView(
          children: [
            for (final event in events)
              ListTile(
                title: Text(event.title),
                subtitle: Text(event.location),
                trailing: IconButton(
                  tooltip: savedEvents.isSaved(event.id)
                      ? 'Unsave ${event.title}'
                      : 'Save ${event.title}',
                  isSelected: savedEvents.isSaved(event.id),
                  icon: const Icon(Icons.bookmark_outline),
                  selectedIcon: const Icon(Icons.bookmark),
                  onPressed: () {
                    if (savedEvents.isSaved(event.id)) {
                      savedEvents.unsave(event.id);
                    } else {
                      savedEvents.save(event.id);
                    }
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
