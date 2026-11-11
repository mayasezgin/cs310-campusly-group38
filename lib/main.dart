import 'package:flutter/material.dart';

import 'screens/events_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/saved_screen.dart';

void main() {
  runApp(const CampuslyApp());
}

class CampuslyApp extends StatelessWidget {
  const CampuslyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Campusly', home: _CampuslyNavigation());
  }
}

class _CampuslyNavigation extends StatefulWidget {
  const _CampuslyNavigation();

  @override
  State<_CampuslyNavigation> createState() => _CampuslyNavigationState();
}

class _CampuslyNavigationState extends State<_CampuslyNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeScreen(),
            MenuScreen(),
            EventsScreen(),
            SavedScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
