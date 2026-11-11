import 'package:flutter/material.dart';
import '../data/sample_menus.dart';


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
    final selectedMenu = menus[selectedDay];

    
return ListView(
  padding: const EdgeInsets.all(20),
  children: [
    const Text(
      'Cafeteria Menu',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF244D43),
      ),
    ),

    const SizedBox(height: 24),
    
Row(
  children: [
    for (var i = 0; i < menus.length; i++)
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(
              '${menus[i].date.day}/${menus[i].date.month}',
            ),
            selected: selectedDay == i,
            onSelected: (_) {
              setState(() {
                selectedDay = i;
              });
            },
          ),
        ),
      ),
  ],
),

const SizedBox(height: 24),

    const Text(
      'Lunch',
      style: TextStyle(fontSize: 20),
    ),

    ...selectedMenu.lunch.map(
      (item) => Card(
        child: ListTile(
          title: Text(item.name),
          subtitle: Text(item.category),
        ),
      ),
    ),

    const SizedBox(height: 24),

    const Text(
      'Dinner',
      style: TextStyle(fontSize: 20),
    ),

    ...selectedMenu.dinner.map(
      (item) => Card(
        child: ListTile(
          title: Text(item.name),
          subtitle: Text(item.category),
        ),
      ),
    ),
  ],
);

  }
}
