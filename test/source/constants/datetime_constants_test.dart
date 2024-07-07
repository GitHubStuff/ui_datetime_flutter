// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DT class tests', () {
    test('makeLocal returns a non-null DateTime object', () {
      expect(DT.makeLocal(null), isA<DateTime>());
    });

    test('makeLocal with null dateTime defaults to the current DateTime', () {
      final now = DateTime.now();
      final localDateTime = DT.makeLocal(null);
      expect(localDateTime.difference(now).inSeconds.abs(), lessThan(5));
    });

    test('makeLocal respects rounding to nearest second', () {
      final dateTime = DateTime(2021, 1, 1, 12, 30, 15, 550);
      final roundedDateTime =
          DT.makeLocal(dateTime, truncateAt: DateTimeUnit.second);
      expect(roundedDateTime.millisecond, equals(0));
    });

    test('makeUtc returns a non-null DateTime object', () {
      expect(DT.makeUtc(null), isA<DateTime>());
    });

    test('makeUtc with null dateTime defaults to the current DateTime in UTC',
        () {
      final now = DateTime.now().toUtc();
      final utcDateTime = DT.makeUtc(null);
      expect(utcDateTime.difference(now).inSeconds.abs(), lessThan(5));
    });

    test('makeUtc respects rounding and time zone conversion', () {
      final dateTime = DateTime(2021, 1, 1, 12, 30, 15, 550).toLocal();
      final roundedUtcDateTime =
          DT.makeUtc(dateTime, truncateAt: DateTimeUnit.minute);
      expect(roundedUtcDateTime.second, equals(0));
      expect(roundedUtcDateTime.minute, equals(30));
      expect(roundedUtcDateTime.isUtc, isTrue);
    });

    // Add more tests as necessary to cover other units, edge cases, etc.
  });
}
