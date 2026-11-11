
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../state/saved_events.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.savedEvents,
  });

  final Event event;
  final SavedEvents savedEvents;

  static const green = Color(0xFF244D43);
  static const cream = Color(0xFFF7F7F0);

  String formatDateTime(DateTime date) {
    String two(int number) => number.toString().padLeft(2, '0');

    return '${two(date.day)}/${two(date.month)}/${date.year} '
        'at ${two(date.hour)}:${two(date.minute)}';
  }

  void showReminderPreview(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reminder Preview'),
        content: Text(
          'A reminder for "${event.title}" would be '
          'scheduled 30 minutes before the event.\n\n'
          'Actual notifications are not enabled yet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Event Details'),
        backgroundColor: cream,
        foregroundColor: green,
      ),
      body: ListenableBuilder(
        listenable: savedEvents,
        builder: (context, child) {
          final isSaved = savedEvents.isSaved(event.id);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EBDD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.event,
                  size: 60,
                  color: green,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                event.category.name.toUpperCase(),
                style: const TextStyle(
                  color: green,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),

              _DetailRow(
                icon: Icons.calendar_today,
                label: 'Starts',
                value: formatDateTime(event.startAt),
              ),

              _DetailRow(
                icon: Icons.schedule,
                label: 'Ends',
                value: formatDateTime(event.endAt),
              ),

              _DetailRow(
                icon: Icons.location_on_outlined,
                label: 'Location',
                value: event.location,
              ),

              _DetailRow(
                icon: Icons.groups_outlined,
                label: 'Organizer',
                value: event.organizerName,
              ),

              const SizedBox(height: 24),

              const Text(
                'About this event',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),

              const SizedBox(height: 10),

              Text(event.description),

              const SizedBox(height: 28),

              ElevatedButton.icon(
                onPressed: () {
                  if (isSaved) {
                    savedEvents.unsave(event.id);
                  } else {
                    savedEvents.save(event.id);
                  }
                },
                icon: Icon(
                  isSaved
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                ),
                label: Text(
                  isSaved ? 'Remove Saved Event' : "I'm Going / Save Event",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: () => showReminderPreview(context),
                icon: const Icon(Icons.notifications_outlined),
                label: const Text('Set Reminder'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: green,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: EventDetailsScreen.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
