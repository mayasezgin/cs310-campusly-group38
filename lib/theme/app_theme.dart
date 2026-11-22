import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Applies the Campusly colors and custom font on top of [base], keeping any
/// other theme settings that [base] already has.
ThemeData campuslyTheme(ThemeData base) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.green,
    primary: AppColors.green,
    secondaryContainer: AppColors.lightGreen,
    onSecondaryContainer: AppColors.green,
    surface: AppColors.cream,
  );

  TextTheme styled(TextTheme textTheme) => textTheme.apply(
    fontFamily: AppTextStyles.fontFamily,
    bodyColor: colorScheme.onSurface,
    displayColor: colorScheme.onSurface,
  );

  return base.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.cream,
    textTheme: styled(base.textTheme),
  );
}
