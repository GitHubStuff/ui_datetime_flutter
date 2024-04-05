import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  test('DateTimeInterval calculates interval correctly', () {
    final startEvent = DateTime(2023, 1, 15);
    final endEvent = DateTime(2024, 1, 15);
    final interval = DateTimeInterval(
        startEvent: startEvent,
        endEvent: endEvent,
        roundedTo: DateTimeUnit.year);

    expect(interval.years, equals(1));
    expect(interval.months, equals(0));
    expect(interval.days, equals(0));
    expect(interval.hours, equals(0));
    expect(interval.minutes, equals(0));
    expect(interval.seconds, equals(0));
    expect(interval.msec, equals(0));
    expect(interval.usec, equals(0));
  });

  test('DateTimeInterval returns correct string representation', () {
    final startEvent = DateTime(2023, 1, 15);
    final endEvent = DateTime(2024, 1, 15);
    final interval = DateTimeInterval(
        startEvent: startEvent,
        endEvent: endEvent,
        roundedTo: DateTimeUnit.month);

    expect(interval.toString(), equals('12 00 00:00:00'));
  });

  // Add more tests for other scenarios as needed
}
