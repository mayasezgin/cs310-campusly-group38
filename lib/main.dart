import 'package:flutter/material.dart';

import 'data/sample_events.dart';
import 'routes/club_routes.dart';
import 'screens/events_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/saved_screen.dart';
import 'state/saved_events.dart';

void main() {
  runApp(const CampuslyApp());
}

class CampuslyApp extends StatelessWidget {
  const CampuslyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campusly',
      home: const _CampuslyNavigation(),
      routes: clubRoutes,
    );
  }
}

class _CampuslyNavigation extends StatefulWidget {
  const _CampuslyNavigation();

  @override
  State<_CampuslyNavigation> createState() => _CampuslyNavigationState();
}

class _CampuslyNavigationState extends State<_CampuslyNavigation> {
  static const _eventsTabIndex = 2;

  final _events = sampleEvents();
  final _savedEvents = SavedEvents();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _savedEvents.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeScreen(onTabSelected: _selectTab),
            const MenuScreen(),
            EventsScreen(events: _events, savedEvents: _savedEvents),
            SavedScreen(
              events: _events,
              savedEvents: _savedEvents,
              onExploreEvents: () => _selectTab(_eventsTabIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
