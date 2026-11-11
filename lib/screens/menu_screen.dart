
import 'package:flutter/material.dart';

import '../data/sample_menus.dart';
import '../models/menu.dart';

const forestGreen = Color(0xFF244D43);
const cream = Color(0xFFF7F7F0);
const lightGreen = Color(0xFFE5EBDD);

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    final menus = sampleMenus();
    final today = menus.first.date;

    final dates = List.generate(
      7,
      (i) => DateTime(today.year, today.month, today.day + i),
    );

    final selectedDate = dates[selectedDay];
    Menu? selectedMenu;

    for (final menu in menus) {
      if (DateUtils.isSameDay(menu.date, selectedDate)) {
        selectedMenu = menu;
        break;
      }
    }

    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
    ];

    return ColoredBox(
      color: cream,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Cafeteria Menu',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: forestGreen,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Fresh meals at the main cafeteria.',
            style: TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 24),

          // Horizontal seven-day selector
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final date = dates[index];
                final selected = selectedDay == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedDay = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 64,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected ? forestGreen : lightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekdays[date.weekday - 1],
                          style: TextStyle(
                            fontSize: 12,
                            color: selected
                                ? Colors.white
                                : forestGreen,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: selected
                                ? Colors.white
                                : forestGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          if (selectedMenu == null)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: forestGreen,
                    size: 36,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Menu not available yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: forestGreen,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please check back later.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            )
          else ...[
            const Text(
              'Lunch',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: forestGreen,
              ),
            ),

            const SizedBox(height: 10),

            for (final item in selectedMenu.lunch)
              _MealCard(item: item),

            const SizedBox(height: 24),

            const Text(
              'Dinner',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: forestGreen,
              ),
            ),

            const SizedBox(height: 10),

            for (final item in selectedMenu.dinner)
              _MealCard(item: item),
          ],
        ],
      ),
    );
  }
}

// Reusable meal card
class _MealCard extends StatelessWidget {
  const _MealCard({required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            SizedBox(
              width: 65,
              child: Text(
                item.category,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  color: forestGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
