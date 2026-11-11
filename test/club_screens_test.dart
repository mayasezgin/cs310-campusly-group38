import 'package:campusly/models/event.dart';
import 'package:campusly/routes/club_routes.dart';
import 'package:campusly/screens/club/add_event_screen.dart';
import 'package:campusly/screens/club/club_dashboard_screen.dart';
import 'package:campusly/screens/club/club_login_screen.dart';
import 'package:campusly/screens/club/club_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Starts on a blank home page and pushes [route] on top of it.
Future<void> pumpRoute(WidgetTester tester, String route) async {
  await tester.pumpWidget(
    MaterialApp(
      routes: clubRoutes,
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pushNamed(route),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

Finder field(String label) => find.descendant(
  of: find.ancestor(of: find.text(label), matching: find.byType(Column)).first,
  matching: find.byType(TextFormField),
);

void main() {
  group('Club Login', () {
    testWidgets('shows inline errors for empty and invalid input', (
      tester,
    ) async {
      await pumpRoute(tester, ClubLoginScreen.routeName);

      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      expect(find.text('Email is required.'), findsOneWidget);
      expect(find.text('Password is required.'), findsOneWidget);

      await tester.enterText(field('Email'), 'not-an-email');
      await tester.enterText(field('Password'), '123');
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      expect(find.text('Enter a valid email address.'), findsOneWidget);
      expect(
        find.text('Password must be at least 6 characters.'),
        findsOneWidget,
      );
      expect(find.byType(ClubDashboardScreen), findsNothing);
    });

    testWidgets('toggles password visibility', (tester) async {
      await pumpRoute(tester, ClubLoginScreen.routeName);
      await tester.tap(find.byTooltip('Show password'));
      await tester.pump();
      expect(find.byTooltip('Hide password'), findsOneWidget);
    });

    testWidgets('valid login opens the dashboard and logout returns home', (
      tester,
    ) async {
      await pumpRoute(tester, ClubLoginScreen.routeName);
      await tester.enterText(field('Email'), 'club@university.edu');
      await tester.enterText(field('Password'), 'secret123');
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      expect(find.byType(ClubDashboardScreen), findsOneWidget);
      expect(find.text('Campus Sustainability Club'), findsOneWidget);
      expect(find.text('3 events'), findsOneWidget);

      await tester.tap(find.text('Log Out'));
      await tester.pumpAndSettle();
      expect(find.text('Open'), findsOneWidget);
    });
  });

  group('Club Sign-Up', () {
    testWidgets('validates fields and password match', (tester) async {
      await pumpRoute(tester, ClubLoginScreen.routeName);
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();
      expect(find.byType(ClubSignUpScreen), findsOneWidget);
      expect(find.textContaining('require approval'), findsOneWidget);

      await tester.enterText(field('Club Name'), 'Chess Club');
      await tester.enterText(field('Email'), 'chess@university.edu');
      await tester.enterText(field('Password'), 'password1');
      await tester.enterText(field('Confirm Password'), 'password2');
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Sign Up'));
      await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
      await tester.pumpAndSettle();
      expect(find.text('Passwords do not match.'), findsOneWidget);

      await tester.enterText(field('Confirm Password'), 'password1');
      await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
      await tester.pumpAndSettle();
      expect(find.text('Request Sent'), findsOneWidget);

      await tester.tap(find.text('Back to Login'));
      await tester.pumpAndSettle();
      expect(find.byType(ClubLoginScreen), findsOneWidget);
    });
  });

  group('Club Dashboard', () {
    testWidgets('shows empty state without events', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ClubDashboardScreen(initialEvents: [])),
      );
      expect(find.text('No events yet'), findsOneWidget);
      expect(find.text('Create Your First Event'), findsOneWidget);
    });
  });

  testWidgets('Add Event button opens the form from the dashboard', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(routes: clubRoutes, home: const ClubDashboardScreen()),
    );
    await tester.tap(find.text('Add Event'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(AddEventScreen), findsOneWidget);
  });

  group('Add Event', () {
    // 9:00 today, so a 16:00 start (the picker default) is in the future.
    final now = DateTime(2026, 11, 12, 9);

    Future<Event?> openForm(WidgetTester tester) async {
      Event? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                result = await Navigator.of(context).push<Event>(
                  MaterialPageRoute(
                    builder: (_) => AddEventScreen(now: () => now),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      return result;
    }

    Future<void> tapPublish(WidgetTester tester) async {
      await tester.tap(find.text('Publish Event'));
      await tester.pumpAndSettle();
    }

    testWidgets('shows required errors on empty submit', (tester) async {
      await openForm(tester);
      await tapPublish(tester);

      expect(find.text('Event title is required.'), findsOneWidget);
      expect(find.text('Date is required.'), findsOneWidget);
      expect(find.text('Start time is required.'), findsOneWidget);
      expect(find.text('End time is required.'), findsOneWidget);
      expect(find.text('Event Created'), findsNothing);
    });

    testWidgets('valid form shows confirmation and returns the event', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.75;
      addTearDown(tester.view.reset);

      Event? created;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                created = await Navigator.of(context).push<Event>(
                  MaterialPageRoute(
                    builder: (_) => AddEventScreen(now: () => now),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(field('Event Title'), 'Tree Planting Day');

      // Date picker opens on today; confirm it.
      await tester.tap(field('Date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Time pickers default to 4:00 PM and 6:00 PM.
      await tester.tap(field('Start Time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(field('End Time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.enterText(field('Location'), 'North Lawn');
      final dropdown = find.byType(DropdownButtonFormField<EventCategory>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Social').last);
      await tester.pumpAndSettle();
      await tester.enterText(
        field('Description'),
        'Help us plant trees around campus.',
      );

      await tapPublish(tester);
      expect(find.text('Event Created'), findsOneWidget);
      await tester.tap(find.text('Back to Dashboard'));
      await tester.pumpAndSettle();

      expect(created, isNotNull);
      expect(created!.title, 'Tree Planting Day');
      expect(created!.category, EventCategory.social);
      expect(created!.startAt, DateTime(2026, 11, 12, 16));
      expect(created!.endAt, DateTime(2026, 11, 12, 18));
    });
  });

  testWidgets('club screens do not overflow on a small phone', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    for (final route in clubRoutes.keys) {
      await tester.pumpWidget(const SizedBox()); // reset navigator
      await pumpRoute(tester, route);
      expect(tester.takeException(), isNull, reason: route);
    }
    await tester.pumpWidget(
      const MaterialApp(home: ClubDashboardScreen(initialEvents: [])),
    );
    expect(tester.takeException(), isNull);
  });
}
