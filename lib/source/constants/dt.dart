import '../enums/datetime_unit.dart';
import '../extensions/datetime_ext.dart';

class DT {
  static const String kDateTimeFormat = 'EEE d-MMM-yyyy h:mm:ss a';

  static const num kMonthsPerYear = 12;
  static const num kHoursPerDay = 24;
  static const num kMinutesPerHour = 60;
  static const num kSecondsPerMinute = 60;
  static const num kMsecPerSecond = 1000;
  static const num kUsecPerMsec = 1000;

  static const num kDaysPlaceholder = 0;
  static const num kDaysJanuary = 31;
  static const num kDaysFebruary = 28;
  static const num kDaysFebruaryLeap = 29;
  static const num kDaysMarch = 31;
  static const num kDaysApril = 30;
  static const num kDaysMay = 31;
  static const num kDaysJune = 30;
  static const num kDaysJuly = 31;
  static const num kDaysAugust = 31;
  static const num kDaysSeptember = 30;
  static const num kDaysOctober = 31;
  static const num kDaysNovember = 30;
  static const num kDaysDecember = 31;

  static DateTime makeLocal(
    DateTime? dateTime, {
    DateTimeUnit truncateAt = DateTimeUnit.second,
  }) =>
      (dateTime ??= DateTime.now())
          .toLocal()
          .truncate(atDateTimeUnit: truncateAt);

  /// Creates a UTC DateTime object with the specified DateTimeUnit precision.
  ///
  /// - [dateTime]: The DateTime object to be rounded (default is the current system time).
  /// - [round]: The DateTimeUnit at which the DateTime should be rounded (default is milliseconds).
  static DateTime makeUtc(
    DateTime? dateTime, {
    DateTimeUnit truncateAt = DateTimeUnit.second,
  }) =>
      (dateTime ??= DateTime.now())
          .toUtc()
          .truncate(atDateTimeUnit: truncateAt);
}
