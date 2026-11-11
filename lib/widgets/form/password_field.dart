import 'package:flutter/material.dart';

import 'labeled_text_field.dart';

/// Password input with a show/hide toggle.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = 'Enter your password',
    this.validator,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return LabeledTextField(
      label: widget.label,
      controller: widget.controller,
      hintText: widget.hintText,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      obscureText: _obscured,
      autofillHints: const [AutofillHints.password],
      suffixIcon: IconButton(
        tooltip: _obscured ? 'Show password' : 'Hide password',
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      ),
    );
  }
}
