
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          ],
        ),
      ),
    );
  }
}
