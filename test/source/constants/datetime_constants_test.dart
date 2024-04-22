import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DT class tests', () {
    test('makeLocal returns a non-null DateTime object', () {
      expect(DT.makeLocal(null), isA<DateTime>());
    });

    test('makeLocal with null dateTime defaults to the current DateTime', () {
      var now = DateTime.now();
      var localDateTime = DT.makeLocal(null);
      expect(localDateTime.difference(now).inSeconds.abs(), lessThan(5));
    });

    test('makeLocal respects rounding to nearest second', () {
      var dateTime = DateTime(2021, 1, 1, 12, 30, 15, 550);
      var roundedDateTime =
          DT.makeLocal(dateTime, truncateAt: DateTimeUnit.second);
      expect(roundedDateTime.millisecond, equals(0));
    });

    test('makeUtc returns a non-null DateTime object', () {
      expect(DT.makeUtc(null), isA<DateTime>());
    });

    test('makeUtc with null dateTime defaults to the current DateTime in UTC',
        () {
      var now = DateTime.now().toUtc();
      var utcDateTime = DT.makeUtc(null);
      expect(utcDateTime.difference(now).inSeconds.abs(), lessThan(5));
    });

    test('makeUtc respects rounding and time zone conversion', () {
      var dateTime = DateTime(2021, 1, 1, 12, 30, 15, 550).toLocal();
      var roundedUtcDateTime =
          DT.makeUtc(dateTime, truncateAt: DateTimeUnit.minute);
      expect(roundedUtcDateTime.second, equals(0));
      expect(roundedUtcDateTime.minute, equals(30));
      expect(roundedUtcDateTime.isUtc, isTrue);
    });

    // Add more tests as necessary to cover other units, edge cases, etc.
  });
}
