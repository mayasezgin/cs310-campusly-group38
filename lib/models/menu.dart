class MenuItem {
  const MenuItem({required this.name, required this.category});

  final String name;
  final String category;
}

class Menu {
  Menu({
    required this.date,
    required List<MenuItem> lunch,
    required List<MenuItem> dinner,
  }) : lunch = List.unmodifiable(lunch),
       dinner = List.unmodifiable(dinner);

  final DateTime date;
  final List<MenuItem> lunch;
  final List<MenuItem> dinner;
}
