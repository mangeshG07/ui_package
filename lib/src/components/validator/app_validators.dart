class AppValidators {
  AppValidators._(); // Private constructor to prevent instantiation

  /// ------------------ Non-empty / Required ------------------
  static String? required(
    String? value, {
    String message = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// ------------------ Email Validator ------------------
  static String? email(
    String? value, {
    String message = 'Enter a valid email',
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email is required';

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(text)) return message;

    return null;
  }

  /// ------------------ Phone Validator ------------------
  static String? phone(
    String? value, {
    String message = 'Enter a valid phone number',
    int length = 10,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Phone number is required';

    final regex = RegExp(r'^\d+$');
    if (!regex.hasMatch(text) || text.length != length) return message;

    return null;
  }

  /// ------------------ Password Validator ------------------
  static String? password(
    String? value, {
    int minLength = 6,
    int maxLength = 32,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
    String message = 'Enter a valid password',
  }) {
    final text = value ?? '';
    if (text.isEmpty) return 'Password is required';
    if (text.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    if (text.length > maxLength) {
      return 'Password must be at most $maxLength characters';
    }

    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(text)) {
      return 'Password must contain an uppercase letter';
    }
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(text)) {
      return 'Password must contain a lowercase letter';
    }
    if (requireDigit && !RegExp(r'\d').hasMatch(text)) {
      return 'Password must contain a number';
    }
    if (requireSpecialChar &&
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text)) {
      return 'Password must contain a special character';
    }

    return null;
  }

  /// ------------------ Website URL Validator ------------------
  static String? website(
    String? value, {
    String message = 'Enter a valid website URL',
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Website URL is required';

    final regex = RegExp(
      r'^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(\/.*)?$',
    );
    if (!regex.hasMatch(text)) return message;

    return null;
  }

  /// ------------------ LinkedIn URL Validator ------------------
  static String? linkedIn(
    String? value, {
    String message = 'Enter a valid LinkedIn URL (profile or company)',
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'LinkedIn profile URL is required';

    final regex = RegExp(
      r'^(https?:\/\/)?(www\.)?linkedin\.com\/(in|company)\/[A-Za-z0-9._-]+\/?(\?.*)?$',
      caseSensitive: false,
    );
    if (!regex.hasMatch(text)) return message;

    return null;
  }

  /// ------------------ Numeric Validator ------------------
  static String? numeric(
    String? value, {
    String message = 'Only numeric values are allowed',
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'This field is required';
    if (!RegExp(r'^\d+$').hasMatch(text)) return message;

    return null;
  }

  /// ------------------ Alphabetic Validator ------------------
  static String? alphabetic(
    String? value, {
    String message = 'Only letters are allowed',
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'This field is required';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(text)) return message;

    return null;
  }

  /// ------------------ Min Length Validator ------------------
  static String? minLength(String? value, int min, {String? message}) {
    final text = value?.trim() ?? '';
    if (text.length < min) {
      return message ?? 'Minimum length is $min characters';
    }
    return null;
  }

  /// ------------------ Max Length Validator ------------------
  static String? maxLength(String? value, int max, {String? message}) {
    final text = value?.trim() ?? '';
    if (text.length > max) {
      return message ?? 'Maximum length is $max characters';
    }
    return null;
  }

  /// ------------------ Custom Regex Validator ------------------
  static String? regex(
    String? value,
    RegExp pattern, {
    String message = 'Invalid format',
  }) {
    final text = value?.trim() ?? '';
    if (!pattern.hasMatch(text)) return message;
    return null;
  }
}

// TextFormField(
// validator: (value) => AppValidators.linkedIn(value),
// decoration: InputDecoration(labelText: 'LinkedIn URL'),
// );
