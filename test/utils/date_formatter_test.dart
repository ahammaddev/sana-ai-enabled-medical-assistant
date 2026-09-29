import 'package:flutter_test/flutter_test.dart';
import 'package:sana/app/utils/constants/helpers/date_formatter.dart';

void main() {
  final now = DateTime(2026, 9, 29, 15, 0);

  group('DateFormatter.relative', () {
    test('shows the time for today', () {
      expect(
        DateFormatter.relative('2026-09-29 09:05:00', now: now),
        '9:05 AM',
      );
    });

    test('shows Yesterday for the previous day', () {
      expect(
        DateFormatter.relative('2026-09-28 23:59:59', now: now),
        'Yesterday',
      );
    });

    test('shows month and day earlier this year', () {
      expect(DateFormatter.relative('2026-03-04 10:00:00', now: now), 'Mar 4');
    });

    test('includes the year for older dates', () {
      expect(
        DateFormatter.relative('2025-12-31 10:00:00', now: now),
        'Dec 31, 2025',
      );
    });

    test('parses ISO-8601 legacy timestamps', () {
      expect(
        DateFormatter.relative('2026-09-29T14:30:00.000', now: now),
        '2:30 PM',
      );
    });

    test('returns unparseable input unchanged', () {
      expect(DateFormatter.relative('', now: now), '');
      expect(DateFormatter.relative('not a date', now: now), 'not a date');
    });
  });

  group('DateFormatter.messageTime', () {
    test('shows only the time for today', () {
      expect(
        DateFormatter.messageTime('2026-09-29 13:45:00', now: now),
        '1:45 PM',
      );
    });

    test('adds the date for earlier days', () {
      expect(
        DateFormatter.messageTime('2026-09-01 08:00:00', now: now),
        'Sep 1, 8:00 AM',
      );
    });

    test('adds the year for previous years', () {
      expect(
        DateFormatter.messageTime('2025-01-02 20:10:00', now: now),
        'Jan 2, 2025 8:10 PM',
      );
    });
  });
}
