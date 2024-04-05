import '../enums/datetime_unit.dart';
import '../extensions/datetime_ext.dart';

class DT {
  static const String kDateTimeFormat = 'EEE d-MMM-yyyy h:mm:ss a';

  static const num monthsPerYear = 12;
  static const num hoursPerDay = 24;
  static const num minutesPerHour = 60;
  static const num secondsPerMinute = 60;
  static const num msecPerSecond = 1000;
  static const num usecPerMsec = 1000;

  static DateTime makeLocal(
    DateTime? dateTime, {
    DateTimeUnit round = DateTimeUnit.msec,
  }) =>
      ((dateTime == null) ? DateTime.now().toLocal() : dateTime.toLocal())
          .truncate(
        at: round,
      );

  /// Creates a UTC DateTime object with the specified DateTimeUnit precision.
  ///
  /// - [dateTime]: The DateTime object to be rounded (default is the current system time).
  /// - [round]: The DateTimeUnit at which the DateTime should be rounded (default is milliseconds).
  static DateTime makeUtc(
    DateTime? dateTime, {
    DateTimeUnit round = DateTimeUnit.msec,
  }) {
    if (dateTime == null) return DateTime.now().toUtc().truncate(at: round);
    if (dateTime.isUtc) return dateTime.truncate(at: round);
    Set<DateTimeUnit> itemSet = round.setFrom();
    assert(itemSet.isNotEmpty, 'itemSet must not be empty');
    return DateTime(
      itemSet.contains(DateTimeUnit.year) ? 0 : dateTime.year,
      itemSet.contains(DateTimeUnit.month) ? 1 : dateTime.month,
      itemSet.contains(DateTimeUnit.day) ? 1 : dateTime.day,
      itemSet.contains(DateTimeUnit.hour) ? 0 : dateTime.hour,
      itemSet.contains(DateTimeUnit.minute) ? 0 : dateTime.minute,
      itemSet.contains(DateTimeUnit.second) ? 0 : dateTime.second,
      itemSet.contains(DateTimeUnit.msec) ? 0 : dateTime.millisecond,
      itemSet.contains(DateTimeUnit.usec) ? 0 : dateTime.microsecond,
    ).toUtc();
  }
}
