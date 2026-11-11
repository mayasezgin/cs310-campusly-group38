
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
          selectedCategory == null ||
          event.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList()
      ..sort((a, b) => a.startAt.compareTo(b.startAt));

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
                    category.name[0].toUpperCase() +
                        category.name.substring(1),
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
                        subtitle: Text(
                          '${event.location}\n'
                          '${event.organizerName}',
                        ),
                        isThreeLine: true,
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
