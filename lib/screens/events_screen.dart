import 'package:flutter/material.dart';

import '../models/event.dart';
import '../state/saved_events.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({
    super.key,
    required this.events,
    required this.savedEvents,
  });

  final List<Event> events;
  final SavedEvents savedEvents;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String searchQuery = '';
  EventCategory? selectedCategory;

  static const primaryGreen = Color(0xFF244D43);
  static const cream = Color(0xFFF7F7F0);
  static const lightGreen = Color(0xFFE5EBDD);

  @override
  Widget build(BuildContext context) {
    final filteredEvents = widget.events.where((event) {
      final query = searchQuery.trim().toLowerCase();

      final matchesSearch =
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.organizerName.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == null || event.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList()..sort((a, b) => a.startAt.compareTo(b.startAt));

    return ColoredBox(
      color: cream,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Campus Events',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: primaryGreen,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Discover what is happening on campus.',
            style: TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 20),

          // Event search bar
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search campus events...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Category filters
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: selectedCategory == null,
                selectedColor: lightGreen,
                onSelected: (_) {
                  setState(() {
                    selectedCategory = null;
                  });
                },
              ),

              for (final category in EventCategory.values)
                ChoiceChip(
                  label: Text(
                    category.name[0].toUpperCase() + category.name.substring(1),
                  ),
                  selected: selectedCategory == category,
                  selectedColor: lightGreen,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryGreen,
            ),
          ),

          const SizedBox(height: 12),

          if (filteredEvents.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No matching events found.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),

          // Existing bookmark functionality
          ListenableBuilder(
            listenable: widget.savedEvents,
            builder: (context, child) {
              return Column(
                children: [
                  for (final event in filteredEvents)
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${event.startAt.day}/${event.startAt.month}/${event.startAt.year} '
                                '• ${event.startAt.hour.toString().padLeft(2, '0')}:'
                                '${event.startAt.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: Color(0xFF244D43),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: _EventUrgencyBadge(event: event),
                              ),

                              const SizedBox(height: 5),

                              Text(event.location),

                              const SizedBox(height: 3),

                              Text('Organized by ${event.organizerName}'),
                            ],
                          ),
                        ),

                        trailing: IconButton(
                          tooltip: widget.savedEvents.isSaved(event.id)
                              ? 'Remove saved event'
                              : 'Save event',
                          icon: Icon(
                            widget.savedEvents.isSaved(event.id)
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            color: primaryGreen,
                          ),
                          onPressed: () {
                            if (widget.savedEvents.isSaved(event.id)) {
                              widget.savedEvents.unsave(event.id);
                            } else {
                              widget.savedEvents.save(event.id);
                            }
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EventUrgencyBadge extends StatelessWidget {
  const _EventUrgencyBadge({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    String label;
    Color background;
    Color textColor;

    if (!now.isBefore(event.endAt)) {
      label = 'Ended';
      background = const Color(0xFFECECEC);
      textColor = const Color(0xFF666666);
    } else if (!now.isBefore(event.startAt)) {
      label = 'Happening now';
      background = const Color(0xFFFCE8E6);
      textColor = const Color(0xFFA52D29);
    } else {
      final timeLeft = event.startAt.difference(now);

      if (timeLeft <= const Duration(hours: 24)) {
        label = 'Within 24 hours';
        background = const Color(0xFFFCE8E6);
        textColor = const Color(0xFFA52D29);
      } else if (timeLeft <= const Duration(hours: 72)) {
        label = 'Within 3 days';
        background = const Color(0xFFFFF2D9);
        textColor = const Color(0xFF995F13);
      } else {
        label = 'Coming up';
        background = const Color(0xFFE5EBDD);
        textColor = const Color(0xFF244D43);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
