import 'package:flutter/material.dart';

/// Shared text styles, built on top of the theme so that the font and the
/// text color always come from one place.
abstract final class AppTextStyles {
  /// Name of the custom font declared in pubspec.yaml.
  static const fontFamily = 'WorkSans';

  static TextTheme _theme(BuildContext context) => Theme.of(context).textTheme;

  /// Big title at the top of a screen.
  static TextStyle? screenTitle(BuildContext context) =>
      _theme(context).headlineMedium?.copyWith(fontWeight: FontWeight.bold);

  /// Title of a section or a highlighted box.
  static TextStyle? sectionTitle(BuildContext context) =>
      _theme(context).titleLarge?.copyWith(fontWeight: FontWeight.w600);

  /// Title inside a card or an empty state.
  static TextStyle? cardTitle(BuildContext context) =>
      _theme(context).titleMedium?.copyWith(fontWeight: FontWeight.w600);

  /// Title of a small info box.
  static TextStyle? boxTitle(BuildContext context) =>
      _theme(context).titleSmall?.copyWith(fontWeight: FontWeight.w600);

  /// Label above a form field.
  static TextStyle? fieldLabel(BuildContext context) =>
      _theme(context).labelLarge?.copyWith(fontWeight: FontWeight.w600);

  /// Regular text.
  static TextStyle? body(BuildContext context) => _theme(context).bodyMedium;

  /// Small helper text.
  static TextStyle? caption(BuildContext context) => _theme(context).bodySmall;

  /// Text of the main button.
  static const button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
