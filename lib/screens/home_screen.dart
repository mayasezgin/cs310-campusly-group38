
import 'package:flutter/material.dart';
import '../data/sample_events.dart';
import '../widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.onTabSelected,
  });

  final ValueChanged<int>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF244D43);
    const backgroundCream = Color(0xFFF7F7F0);
    const lightGreen = Color(0xFFE5EBDD);

    return Container(
      color: backgroundCream,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campusly header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Campusly',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    Text(
                      'Your campus, connected.',
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryGreen.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Notifications'),
                        content: const Text(
                          'Event reminders will appear here.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search campus events...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),


            // Home Screen shortcuts
            
            // Home Screen shortcuts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HomeShortcut(
                  icon: Icons.restaurant_menu,
                  label: 'Menu',
                  onTap: () => onTabSelected?.call(1),
                ),
                _HomeShortcut(
                  icon: Icons.event_outlined,
                  label: 'Events',
                  onTap: () => onTabSelected?.call(2),
                ),
                const _HomeShortcut(
                  icon: Icons.groups_outlined,
                  label: 'Clubs',
                ),
                _HomeShortcut(
                  icon: Icons.bookmark_outline,
                  label: 'Saved',
                  onTap: () => onTabSelected?.call(3),
                ),
                const _HomeShortcut(
                  icon: Icons.login,
                  label: 'Login',
                ),
              ],
            ),


            const SizedBox(height: 28),

            
            // Cafeteria section
            const Text(
              "Today's Cafeteria Menu",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fresh meals on campus',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lunch and dinner menus will appear here.',
                    style: TextStyle(color: primaryGreen),
                  ),
                ],
              ),
            ),
              // Upcoming Events section
            const SizedBox(height: 28),

            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 12),

          ...sampleEvents().take(2).map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: EventCard(event: event),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeShortcut extends StatelessWidget {
  const _HomeShortcut({
    required this.icon,
    required this.label,
    this.onTap
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF244D43);
    const lightGreen = Color(0xFFE5EBDD);

    return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primaryGreen,
            size: 23,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: primaryGreen,
            fontSize: 11,
          ),
        ),
      ],
     ),
    );
  }
}

