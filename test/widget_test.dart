import 'package:campusly/main.dart';
import 'package:campusly/screens/events_screen.dart';
import 'package:campusly/screens/home_screen.dart';
import 'package:campusly/screens/menu_screen.dart';
import 'package:campusly/screens/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Starts on Home and opens each tab', (tester) async {
    await tester.pumpWidget(const CampuslyApp());

    const screens = {
      'Home': HomeScreen,
      'Menu': MenuScreen,
      'Events': EventsScreen,
      'Saved': SavedScreen,
    };

    void expectVisibleScreen(String selectedTab) {
      for (final screen in screens.entries) {
        expect(
          find.byType(screen.value),
          screen.key == selectedTab ? findsOneWidget : findsNothing,
        );
      }
    }

    expectVisibleScreen('Home');

    for (final label in ['Menu', 'Events', 'Saved', 'Home']) {
      final destination = find.widgetWithText(NavigationDestination, label);
      await tester.tap(destination);
      await tester.pumpAndSettle();

      expectVisibleScreen(label);
    }
  });
}
