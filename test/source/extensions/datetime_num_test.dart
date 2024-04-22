import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DateTimeNum Extension Tests', () {
    test('asMonths should convert years to months correctly', () {
      expect(2.asMonths(), 24); // Assuming monthsPerYear is 12
    });

    test('asHours should convert days to hours correctly', () {
      expect(2.asHours(), 48); // Assuming hoursPerDay is 24
    });

    test('asMinutes should convert hours to minutes correctly', () {
      expect(2.asMinutes(), 120); // Assuming minutesPerHour is 60
    });

    test('asSeconds should convert minutes to seconds correctly', () {
      expect(2.asSeconds(), 120); // Assuming secondsPerMinute is 60
    });

    test('asMilliseconds should convert seconds to milliseconds correctly', () {
      expect(2.asMilliseconds(), 2000); // Assuming msecPerSecond is 1000
    });

    test('asMicroseconds should convert milliseconds to microseconds correctly',
        () {
      expect(2.asMicroseconds(), 2000); // Assuming usecPerMsec is 1000
    });
  });
}
