
import 'package:flutter/material.dart';

// Colors used throughout Campusly
class CampuslyColors {
  static const green = Color(0xFF244D43);
  static const cream = Color(0xFFF7F7F0);
  static const lightGreen = Color(0xFFE5EBDD);
}

// Consistent spacing between elements
class CampuslySpacing {
  static const small = 8.0;
  static const medium = 16.0;
  static const large = 24.0;
}

// Shared text styles
class CampuslyTextStyles {
  static const pageTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: CampuslyColors.green,
  );

  static const sectionTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: CampuslyColors.green,
  );

  static const body = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: CampuslyColors.green,
  );
}
