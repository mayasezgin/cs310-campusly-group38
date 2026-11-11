import 'package:flutter/material.dart';

import '../../data/sample_club_events.dart';
import '../../models/event.dart';
import '../../utils/date_labels.dart';
import '../../utils/event_category_labels.dart';
import '../../widgets/club_event_card.dart';
import '../../widgets/primary_button.dart';
import 'add_event_screen.dart';

/// Dashboard for a logged-in club: shows the club's posted events and lets
/// the club add new events or log out.
class ClubDashboardScreen extends StatefulWidget {
  const ClubDashboardScreen({super.key, this.initialEvents});

  static const routeName = '/club/dashboard';

  /// Events to show at start. Defaults to the sample club events.
  final List<Event>? initialEvents;

  @override
  State<ClubDashboardScreen> createState() => _ClubDashboardScreenState();
}

class _ClubDashboardScreenState extends State<ClubDashboardScreen> {
  late final List<Event> _events = [
    ...(widget.initialEvents ?? sampleClubEvents()),
  ];

  Future<void> _addEvent() async {
    // A typed route is needed so the form can return the new Event;
    // pushNamed<Event> would fail because named routes are untyped.
    final created = await Navigator.of(context).push<Event>(
      MaterialPageRoute(
        settings: const RouteSettings(name: AddEventScreen.routeName),
        builder: (_) => const AddEventScreen(),
      ),
    );
    if (created == null || !mounted) return;
    setState(() {
      _events
        ..add(created)
        ..sort((a, b) => a.startAt.compareTo(b.startAt));
    });
  }

  void _logOut() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _showEvent(Event event) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _EventPreviewSheet(event: event),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final count = _events.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    sliver: SliverList.list(
                      children: [
                        Text(
                          'Club Dashboard',
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Campusly · Club account',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome back,', style: textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Text(
                                sampleClubName,
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Bring your campus community together.',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Your Posted Events',
                                style: textTheme.titleLarge,
                              ),
                            ),
                            Text(
                              '$count ${count == 1 ? 'event' : 'events'}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  if (_events.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverList.builder(
                        itemCount: _events.length,
                        itemBuilder: (context, index) => ClubEventCard(
                          event: _events[index],
                          onTap: () => _showEvent(_events[index]),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Column(
                children: [
                  PrimaryButton(
                    label: _events.isEmpty
                        ? 'Create Your First Event'
                        : 'Add Event',
                    icon: Icons.add,
                    onPressed: _addEvent,
                  ),
                  TextButton.icon(
                    onPressed: _logOut,
                    icon: const Icon(Icons.logout),
                    label: const Text('Log Out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note_outlined, size: 64, color: colors.primary),
          const SizedBox(height: 16),
          Text(
            'No events yet',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Your club has not published any events. '
            'Create your first event to reach students on campus.',
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _EventPreviewSheet extends StatelessWidget {
  const _EventPreviewSheet({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              event.title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(eventTimeRangeLabel(event.startAt, event.endAt)),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.location_on_outlined),
              title: Text(event.location),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.category_outlined),
              title: Text(categoryLabel(event.category)),
            ),
            const SizedBox(height: 8),
            Text(event.description, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
