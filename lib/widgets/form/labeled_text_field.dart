import 'package:flutter/material.dart';

/// A text input with a label above it, matching the Campusly form design.
///
/// Used by the club login, sign-up and add event forms so that every field
/// shares the same spacing, label style and validation message style.
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.suffixIcon,
    this.onTap,
    this.autofillHints,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return FieldLabel(
      label: label,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxLines,
        onTap: onTap,
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: campuslyInputDecoration(
          context,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

/// Puts a small bold label above any form [child].
class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

/// Input decoration shared by every Campusly form field.
InputDecoration campuslyInputDecoration(
  BuildContext context, {
  String? hintText,
  Widget? suffixIcon,
}) {
  final colors = Theme.of(context).colorScheme;
  OutlineInputBorder border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  return InputDecoration(
    hintText: hintText,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: colors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: border(colors.outlineVariant),
    enabledBorder: border(colors.outlineVariant),
    focusedBorder: border(colors.primary, 1.5),
    errorBorder: border(colors.error),
    focusedErrorBorder: border(colors.error, 1.5),
    errorMaxLines: 2,
  );
}
