import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static const String storagePattern = 'yyyy-MM-dd HH:mm:ss';

  static String now() => DateFormat(storagePattern).format(DateTime.now());

  /// Short label for list items: time today, 'Yesterday', or a date.
  static String relative(String raw, {DateTime? now}) {
    final date = DateTime.tryParse(raw);
    if (date == null) return raw;
    final today = _dayOf(now ?? DateTime.now());
    final diff = today.difference(_dayOf(date)).inDays;

    if (diff == 0) return DateFormat('h:mm a').format(date);
    if (diff == 1) return 'Yesterday';
    if (date.year == today.year) return DateFormat('MMM d').format(date);
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Label for chat bubbles: time today, otherwise date with time.
  static String messageTime(String raw, {DateTime? now}) {
    final date = DateTime.tryParse(raw);
    if (date == null) return raw;
    final today = _dayOf(now ?? DateTime.now());

    if (_dayOf(date) == today) return DateFormat('h:mm a').format(date);
    if (date.year == today.year) {
      return DateFormat('MMM d, h:mm a').format(date);
    }
    return DateFormat('MMM d, yyyy h:mm a').format(date);
  }

  static DateTime _dayOf(DateTime d) => DateTime(d.year, d.month, d.day);
}
