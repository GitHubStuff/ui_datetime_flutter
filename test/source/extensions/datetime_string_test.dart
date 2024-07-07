import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DateTimeString Extension Tests', () {
    test('dateTimeUnitOrNull should correctly identify valid DateTimeUnits',
        () {
      expect('year'.dateTimeUnitOrNull(), DateTimeUnit.year);
      expect('month'.dateTimeUnitOrNull(), DateTimeUnit.month);
      expect('day'.dateTimeUnitOrNull(), DateTimeUnit.day);
      expect('hour'.dateTimeUnitOrNull(), DateTimeUnit.hour);
      expect('minute'.dateTimeUnitOrNull(), DateTimeUnit.minute);
      expect('second'.dateTimeUnitOrNull(), DateTimeUnit.second);
    });

    test('dateTimeUnitOrNull should return null for invalid units', () {
      expect('century'.dateTimeUnitOrNull(), isNull);
    });

    test('formattedDateTime should correctly format a DateTime', () {
      final testDateTime = DateTime(2023, 1, 15, 5, 45, 9);
      expect(
        'yyyy-MM-dd HH:mm:ss'.formattedDateTime(testDateTime),
        '2023-01-15 05:45:09',
      );
      expect('yy/M/d H:m:s'.formattedDateTime(testDateTime), '23/1/15 5:45:9');
      expect('dd-MM-yyyy'.formattedDateTime(testDateTime), '15-01-2023');
    });

    test('formattedDateTime should use current DateTime if null provided', () {
      final now = DateTime.now();
      final formattedNow = 'yyyy-MM-dd'.formattedDateTime(null);
      expect(formattedNow, contains(now.year.toString()));
      expect(formattedNow, contains(now.month.toString().padLeft(2, '0')));
      expect(formattedNow, contains(now.day.toString().padLeft(2, '0')));
    });
  });
}
