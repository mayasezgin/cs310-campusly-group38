import 'package:flutter/material.dart';

import '../screens/club/add_event_screen.dart';
import '../screens/club/club_dashboard_screen.dart';
import '../screens/club/club_login_screen.dart';
import '../screens/club/club_signup_screen.dart';

/// Named routes for the club flow:
/// Club Login → Club Sign-Up, Club Login → Club Dashboard → Add Event.
final Map<String, WidgetBuilder> clubRoutes = {
  ClubLoginScreen.routeName: (_) => const ClubLoginScreen(),
  ClubSignUpScreen.routeName: (_) => const ClubSignUpScreen(),
  ClubDashboardScreen.routeName: (_) => const ClubDashboardScreen(),
  AddEventScreen.routeName: (_) => const AddEventScreen(),
};
