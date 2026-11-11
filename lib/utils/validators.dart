/// Shared validation helpers for Campusly forms.
///
/// Each function follows the [FormFieldValidator] contract: it returns `null`
/// when the value is valid and an error message otherwise.
class Validators {
  Validators._();

  static final _emailPattern = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? email(String? value) {
    final missing = required(value, 'Email');
    if (missing != null) return missing;
    if (!_emailPattern.hasMatch(value!.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    final missing = required(value, 'Password');
    if (missing != null) return missing;
    if (value!.length < minLength) {
      return 'Password must be at least $minLength characters.';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? length(
    String? value,
    String fieldName, {
    int min = 0,
    int? max,
  }) {
    final missing = required(value, fieldName);
    if (missing != null) return missing;
    final length = value!.trim().length;
    if (length < min) {
      return '$fieldName must be at least $min characters.';
    }
    if (max != null && length > max) {
      return '$fieldName must be at most $max characters.';
    }
    return null;
  }
}
