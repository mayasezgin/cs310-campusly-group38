import 'package:flutter/material.dart';

void main() {
  runApp(const CampuslyApp());
}

class CampuslyApp extends StatelessWidget {
  const CampuslyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Campusly',
      home: Scaffold(body: Center(child: Text('Campusly'))),
    );
  }
}
