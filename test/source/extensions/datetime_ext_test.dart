import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart'; // Required for DateFormat if used in tests

void main() {
  group('DateTimeExt Tests', () {
    test('formatted should return correctly formatted date string', () {
      var testDate = DateTime(2023, 1, 1);
      expect(testDate.formatted(), equals('Sun 1-Jan-2023 12:00:00 AM'));
    });

    test('daysInMonth should handle non-leap year February', () {
      var testDate = DateTime(2021, 2, 1);
      expect(testDate.daysInMonth, 28);
    });

    test('daysInMonth should handle leap year February', () {
      var testDate = DateTime(2024, 2, 1);
      expect(testDate.daysInMonth, 29);
    });

    test('addToMonth should handle month addition with rollover to next year',
        () {
      var testDate = DateTime(2023, 11, 1, 1).toUtc();
      var expectedDate =
          DateTime(2024, 1, 1, 0).toUtc(); // Rolling over to January next year
      expect(testDate.addToMonth(2), equals(expectedDate));
    });

    test('isLeapYear should identify leap and non-leap years correctly', () {
      expect(DateTime(2024, 1, 1).isLeapYear(), true);
      expect(DateTime(2021, 1, 1).isLeapYear(), false);
    });
  });
}
