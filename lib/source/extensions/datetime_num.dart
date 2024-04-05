import '../constants/datetime_constats.dart';

extension DateTimeNum on num {
  /// Converts the numeric value to months.
  ///
  /// This extension multiplies the numeric value by the constant [monthsPerYear]
  /// to convert it to months.
  num asMonths() => (this * DT.monthsPerYear);

  /// Converts the numeric value to hours.
  ///
  /// This extension multiplies the numeric value by the constant [hoursPerDay]
  /// to convert it to hours.
  num asHours() => (this * DT.hoursPerDay);

  /// Converts the numeric value to minutes.
  ///
  /// This extension multiplies the numeric value by the constant [minutesPerHour]
  /// to convert it to minutes.
  num asMinutes() => (this * DT.minutesPerHour);

  /// Converts the numeric value to seconds.
  ///
  /// This extension multiplies the numeric value by the constant [secondsPerMinute]
  /// to convert it to seconds.
  num asSeconds() => (this * DT.secondsPerMinute);

  /// Converts the numeric value to milliseconds.
  ///
  /// This extension multiplies the numeric value by the constant [msecondsPerSecond]
  /// to convert it to milliseconds.
  num asMilliseconds() => (this * DT.msecPerSecond);

  /// Converts the numeric value to microseconds.
  ///
  /// This extension multiplies the numeric value by the constant [usecondsPerMillisecond]
  /// to convert it to microseconds.
  num asMicroseconds() => (this * DT.usecPerMsec);
}
