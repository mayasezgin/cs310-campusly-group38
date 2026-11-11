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

  testWidgets('Saved cards and Events bookmarks share state', (tester) async {
    await tester.pumpWidget(const CampuslyApp());

    Future<void> openTab(String label) async {
      await tester.tap(find.widgetWithText(NavigationDestination, label));
      await tester.pumpAndSettle();
    }

    const title = 'Study Skills Workshop';
    final save = find.byTooltip('Save $title');
    final unsave = find.byTooltip('Unsave $title');
    final explore = find.widgetWithText(FilledButton, 'Explore Events');
    final savedCard = find.widgetWithText(Card, title);

    await openTab('Saved');
    await tester.tap(explore);
    await tester.pumpAndSettle();
    expect(find.byType(EventsScreen), findsOneWidget);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      2,
    );

    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(unsave, findsOneWidget);

    await openTab('Saved');
    expect(savedCard, findsOneWidget);
    await tester.tap(
      find.descendant(of: savedCard, matching: find.text('Remove')),
    );
    await tester.pumpAndSettle();
    expect(savedCard, findsNothing);
    expect(explore, findsOneWidget);

    await tester.tap(explore);
    await tester.pumpAndSettle();
    expect(save, findsOneWidget);
    expect(unsave, findsNothing);
  });
}
