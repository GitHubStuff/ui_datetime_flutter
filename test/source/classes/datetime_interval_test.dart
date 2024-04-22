import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DateTimeInterval Tests', () {
    test('Exact same datetime', () {
      DateTime sameDateTime = DateTime.now();
      DateTimeInterval interval = DateTimeInterval(
        startEvent: sameDateTime,
        endEvent: sameDateTime,
      );
      expect(interval.toString(), equals('00:00:00'));
    });

    test('One year difference', () {
      DateTime start = DateTime(2023, 1, 1);
      DateTime end = DateTime(2024, 1, 1);
      DateTimeInterval interval = DateTimeInterval(
        startEvent: start,
        endEvent: end,
        firstDateTimeUnit: DateTimeUnit.year,
      );
      expect(interval.toString(), equals('1 00 00 00:00:00'));
    });

    test('Negative interval (end before start)', () {
      DateTime start = DateTime(2024, 1, 1);
      DateTime end = DateTime(2023, 1, 1);
      DateTimeInterval interval = DateTimeInterval(
        startEvent: start,
        endEvent: end,
      );
      expect(interval.toString(),
          startsWith('-')); // Assuming negative interval is prefixed with '-'
    });

    test('Mixed units interval', () {
      DateTime start = DateTime(2021, 3, 15, 12, 30, 45);
      DateTime end = DateTime(2023, 6, 20, 14, 45, 50);
      DateTimeInterval interval = DateTimeInterval(
        startEvent: start,
        endEvent: end,
        firstDateTimeUnit: DateTimeUnit.month,
      );
      // The exact output will depend on your implementation details
      expect(interval.toString(),
          contains('27 05 02:15:05')); // Check that months are mentioned
    });

    test('Leap year day count', () {
      DateTime start = DateTime(2020, 2, 28);
      DateTime end = DateTime(2020, 3, 1);
      DateTimeInterval interval = DateTimeInterval(
        startEvent: start,
        endEvent: end,
      );
      expect(interval.days, equals(2)); // 2020 is a leap year
    });

    test('Leap year day count to non-leap year', () {
      DateTime start = DateTime(2020, 2, 28);
      DateTime end = DateTime(2021, 3, 1);
      DateTimeInterval interval = DateTimeInterval(
        startEvent: start,
        endEvent: end,
      );
      expect(interval.years, equals(1));
      expect(interval.days, equals(1)); // 2020 is a leap year
    });
    test('Time zone handling', () {
      DateTime start = DateTime.utc(2023, 1, 1, 5); // UTC time
      DateTime end = DateTime.utc(2023, 1, 1, 8); // UTC time
      DateTimeInterval interval = DateTimeInterval(
        startEvent: start,
        endEvent: end,
      );
      expect(interval.hours,
          equals(3)); // Time difference should be calculated correctly in UTC
    });
  });
  test('DateTimeInterval calculates interval correctly', () {
    final startEvent = DateTime(2023, 1, 15);
    final endEvent = DateTime(2024, 1, 15);
    final interval = DateTimeInterval(
        startEvent: startEvent,
        endEvent: endEvent,
        firstDateTimeUnit: DateTimeUnit.year);

    expect(interval.years, equals(1));
    expect(interval.months, equals(0));
    expect(interval.days, equals(0));
    expect(interval.hours, equals(0));
    expect(interval.minutes, equals(0));
    expect(interval.seconds, equals(0));
    expect(interval.msecs, equals(0));
    expect(interval.usecs, equals(0));
  });

  test('DateTimeInterval returns correct string representation', () {
    final startEvent = DateTime(2023, 1, 15);
    final endEvent = DateTime(2024, 1, 15);
    final interval = DateTimeInterval(
        startEvent: startEvent,
        endEvent: endEvent,
        firstDateTimeUnit: DateTimeUnit.month);

    expect(interval.toString(), equals('12 00 00:00:00'));
  });

  // Add more tests for other scenarios as needed
}
