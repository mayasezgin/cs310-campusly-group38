import '../models/menu.dart';

/// Returns cafeteria menus for today and the next two local calendar days.
List<Menu> sampleMenus({DateTime? now}) {
  final today = (now ?? DateTime.now()).toLocal();

  DateTime date(int daysFromToday) =>
      DateTime(today.year, today.month, today.day + daysFromToday);

  return [
    Menu(
      date: date(0),
      lunch: const [
        MenuItem(name: 'Lentil soup', category: 'Soup'),
        MenuItem(name: 'Grilled chicken', category: 'Main'),
        MenuItem(name: 'Bulgur pilaf', category: 'Side'),
      ],
      dinner: const [
        MenuItem(name: 'Baked vegetable pasta', category: 'Main'),
        MenuItem(name: 'Green salad', category: 'Salad'),
      ],
    ),
    Menu(
      date: date(1),
      lunch: const [
        MenuItem(name: 'Tomato soup', category: 'Soup'),
        MenuItem(name: 'Chickpea stew', category: 'Main'),
        MenuItem(name: 'Rice pilaf', category: 'Side'),
      ],
      dinner: const [
        MenuItem(name: 'Grilled meatballs', category: 'Main'),
        MenuItem(name: 'Roasted potatoes', category: 'Side'),
      ],
    ),
    Menu(
      date: date(2),
      lunch: const [
        MenuItem(name: 'Vegetable soup', category: 'Soup'),
        MenuItem(name: 'Baked fish', category: 'Main'),
        MenuItem(name: 'Carrot salad', category: 'Salad'),
      ],
      dinner: const [
        MenuItem(name: 'Stuffed peppers', category: 'Main'),
        MenuItem(name: 'Rice pudding', category: 'Dessert'),
      ],
    ),
  ];
}
