import 'package:intl/intl.dart';

/// A professional timestamp formatter that converts date strings into
/// relative time like "Just now", "5m ago", "2h ago", etc.
///
/// Example usage:
/// ```dart
/// TimestampFormatter.format("2025-02-10 14:30:00"); // "Just now" or "5m ago"
/// ```
class TimestampFormatter {
  /// Optional custom formats to parse the timestamp
  final List<String> customFormats;
  final String locale;

  TimestampFormatter({
    this.customFormats = const [
      'MMM dd, yyyy hh:mm a', // Dec 01, 2025 12:08 PM
      'yyyy-MM-dd HH:mm:ss', // ISO-like format
      'yyyy-MM-ddTHH:mm:ssZ', // ISO-8601
      'MM/dd/yyyy HH:mm', // US format
    ],
    this.locale = 'en_US',
  });

  /// Converts a timestamp string into relative time
  String format(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return 'Just now';

    DateTime? parsedDate;

    for (final format in customFormats) {
      try {
        parsedDate = DateFormat(format, locale).parse(timestamp);
        break;
      } catch (_) {}
    }

    parsedDate ??= _tryParseIso(timestamp);
    if (parsedDate == null) return timestamp;

    return _getRelativeTime(parsedDate);
  }

  DateTime? _tryParseIso(String timestamp) {
    try {
      return DateTime.parse(timestamp);
    } catch (_) {
      return null;
    }
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      final diff = dateTime.difference(now);
      if (diff.inDays > 365) {
        return DateFormat('MMM d, yyyy', locale).format(dateTime);
      } else if (diff.inDays > 30) {
        return DateFormat('MMM d', locale).format(dateTime);
      } else {
        return 'In ${diff.inDays} ${diff.inDays == 1 ? 'day' : 'days'}';
      }
    }

    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30)
      return '${(difference.inDays / 7).floor()}w ago';
    if (difference.inDays < 365)
      return '${(difference.inDays / 30).floor()}mo ago';

    return DateFormat('MMM d, yyyy', locale).format(dateTime);
  }
}
