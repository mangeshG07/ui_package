extension StringExtensions on String {
  // Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  // Capitalize each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  // Check if string is email
  bool get isEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  // Check if string is URL
  bool get isUrl {
    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return urlRegex.hasMatch(this);
  }

  // // Truncate string
  // String truncate(int maxLength, {String suffix = '...'}) {
  //   if (length <= maxLength) return this;
  //   return '${substring(0, maxLength)}$suffix';
  // }

  /// Capitalizes the first letter of the string
  // String capitalize() {
  //   if (isEmpty) return this;
  //   return '${this[0].toUpperCase()}${substring(1)}';
  // }

  /// Capitalizes the first letter of each word
  String titleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Removes all whitespace from the string
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Removes leading and trailing whitespace from the string
  String trim() {
    return this;
  }

  /// Checks if the string is email format
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  /// Checks if the string is a valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(r'^https?:\/\/[^\s$.?#].[^\s]*$', caseSensitive: false);
    return urlRegex.hasMatch(this);
  }

  /// Truncates the string to a specified length with optional ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    if (maxLength <= 3) return maxLength == 3 ? '...' : substring(0, maxLength);
    return '${substring(0, maxLength - 3)}$ellipsis';
  }

  /// Reverses the string
  String reversed() {
    return split('').reversed.join('');
  }

  /// Checks if string contains only alphabetic characters
  bool get isAlphabetic {
    final alphaRegex = RegExp(r'^[a-zA-Z]+$');
    return alphaRegex.hasMatch(this);
  }

  /// Checks if string contains only numeric characters
  bool get isNumeric {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(this);
  }

  /// Converts string to camelCase
  String toCamelCase() {
    if (isEmpty) return this;
    final words = split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((word) => word.capitalize()).join();
  }

  /// Converts string to snake_case
  String toSnakeCase() {
    return replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase();
  }

  /// Converts string to kebab-case
  String toKebabCase() {
    return replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-').toLowerCase();
  }

  /// Adds plural 's' if count is not 1
  String pluralize(num count) {
    return count == 1 ? this : '$this s';
  }
}

extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
