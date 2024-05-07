import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DateTimeUnit', () {
    test('next returns the next DateTimeUnit correctly', () {
      expect(DateTimeUnit.year.next, DateTimeUnit.month);
      expect(DateTimeUnit.month.next, DateTimeUnit.day);
      expect(DateTimeUnit.day.next, DateTimeUnit.hour);
      expect(DateTimeUnit.hour.next, DateTimeUnit.minute);
      expect(DateTimeUnit.minute.next, DateTimeUnit.second);
      expect(DateTimeUnit.second.next, DateTimeUnit.msec);
      expect(DateTimeUnit.msec.next, DateTimeUnit.usec);
      expect(DateTimeUnit.usec.next, equals(null)); // Last item returns itself
    });

    test('setFrom returns correct set of DateTimeUnits', () {
      expect(
          DateTimeUnit.year.sublist(),
          containsAllInOrder([
            DateTimeUnit.year,
            DateTimeUnit.month,
            DateTimeUnit.day,
            DateTimeUnit.hour,
            DateTimeUnit.minute,
            DateTimeUnit.second,
            DateTimeUnit.msec,
            DateTimeUnit.usec,
          ]));
      expect(
          DateTimeUnit.minute.sublist(),
          containsAllInOrder([
            DateTimeUnit.minute,
            DateTimeUnit.second,
            DateTimeUnit.msec,
            DateTimeUnit.usec,
          ]));
      expect(DateTimeUnit.usec.sublist(), [DateTimeUnit.usec]);
    });
  });
  group('DateTimeUnit', () {
    test('next should return the next DateTimeUnit', () {
      expect(DateTimeUnit.year.next, DateTimeUnit.month);
      expect(DateTimeUnit.second.next, DateTimeUnit.msec);
    });

    test('next should return itself if it is the last unit', () {
      expect(DateTimeUnit.usec.next, equals(null));
    });

    // test(
    //     'checkPrecision should throw an ArgumentError when using excluded units',
    //     () {
    //   expect(() => DateTimeUnit.msec.checkPrecision(), throwsArgumentError);
    //   expect(() => DateTimeUnit.usec.checkPrecision(), throwsArgumentError);
    // });

    // test('checkPrecision should not throw for other units', () {
    //   expect(() => DateTimeUnit.year.checkPrecision(), returnsNormally);
    //   expect(() => DateTimeUnit.second.checkPrecision(), returnsNormally);
    // });

    test(
        'setFrom should return a set of DateTimeUnits starting from the current unit',
        () {
      expect(
          DateTimeUnit.day.sublist(),
          containsAllInOrder([
            DateTimeUnit.day,
            DateTimeUnit.hour,
            DateTimeUnit.minute,
            DateTimeUnit.second,
            DateTimeUnit.msec,
            DateTimeUnit.usec
          ]));
      expect(DateTimeUnit.msec.sublist(),
          containsAllInOrder([DateTimeUnit.msec, DateTimeUnit.usec]));
    });
  });
}
