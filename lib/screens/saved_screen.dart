import 'package:flutter/material.dart';

import '../models/event.dart';
import '../state/saved_events.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({
    super.key,
    required this.events,
    required this.savedEvents,
    required this.onExploreEvents,
  });

  final List<Event> events;
  final SavedEvents savedEvents;
  final VoidCallback onExploreEvents;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: savedEvents,
      builder: (context, child) {
        final saved = events.where((event) => savedEvents.isSaved(event.id));
        if (saved.isEmpty) {
          return Center(
            child: FilledButton(
              onPressed: onExploreEvents,
              child: const Text('Explore Events'),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            for (final event in saved)
              Card(
                child: ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.location),
                  trailing: TextButton(
                    onPressed: () => savedEvents.unsave(event.id),
                    child: const Text('Remove'),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
