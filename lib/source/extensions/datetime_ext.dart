import 'dart:math';

import 'package:intl/intl.dart';

import '../classes/datetime_interval.dart';
import '../constants/dt.dart';
import '../enums/datetime_unit.dart';

extension DateTimeExt on DateTime {
  String formatted({
    String format = DT.kDateTimeFormat,
    bool asUtc = false,
  }) =>
      DateFormat(format).format(asUtc ? DT.makeUtc(this) : DT.makeLocal(this));

  /// An extension for the DateTime class providing additional functionality.
  /// Returns the number of days in the month and accounts for leap years.
  /// As DateTime() starts with 1 for January, the placeholder 0 is used for the first element.
  num get daysInMonth => [
        0,
        31, // January
        28 + (isLeapYear() ? 1 : 0),
        31, // March
        30, // April
        31, // May
        30, // June
        31, // July
        31, // August
        30, // September
        31, // October
        30, // November
        31, // December
      ][month];

  DateTime adjustMonth(int addedMonths, {bool setToLastDay = false}) {
    int years = (month + addedMonths - 1) ~/ 12;
    int newMonth = (month + addedMonths - 1) % 12 + 1;
    int newYear = year + years;

    if (setToLastDay) {
      return DateTime.utc(newYear, newMonth + 1, 0, hour, minute, second,
          millisecond, microsecond);
    } else {
      int newDay = min(day, DateTime.utc(newYear, newMonth + 1, 0).day);
      return DateTime.utc(newYear, newMonth, newDay, hour, minute, second,
          millisecond, microsecond);
    }
  }

  DateTime addToMonth(int months, {bool setToLastDay = false}) =>
      adjustMonth(months, setToLastDay: setToLastDay);

  DateTime addToYear(int years, {bool setToLastDay = false}) =>
      adjustMonth(years * 12, setToLastDay: setToLastDay);

  /// Returns the Interval between this DateTime and a target DateTime.
  DateTimeDifference interval({
    DateTime? targetDateTime,
    DateTimeUnit roundedTo = DateTimeUnit.year,
  }) =>
      DateTimeDifference(
        startEvent: this,
        endEvent: targetDateTime ?? DateTime.now(),
        firstDateTimeUnit: roundedTo,
      );

  /// Returns true/false if the year is a leap year.
  bool isLeapYear() => (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  /// Returns true/false if the DateTime is the last day of the month.
  bool isLastDayOfMonth() => day == daysInMonth;

  DateTime updateInterval(DateTimeUnit onType, int amount,
      {bool setToLastDay = false}) {
    switch (onType) {
      case DateTimeUnit.year:
        return addToYear(amount, setToLastDay: setToLastDay);
      case DateTimeUnit.month:
        return addToMonth(amount, setToLastDay: setToLastDay);
      default:
        return add(Duration(
          days: onType == DateTimeUnit.day ? amount : 0,
          hours: onType == DateTimeUnit.hour ? amount : 0,
          minutes: onType == DateTimeUnit.minute ? amount : 0,
          seconds: onType == DateTimeUnit.second ? amount : 0,
          milliseconds: onType == DateTimeUnit.msec ? amount : 0,
          microseconds: onType == DateTimeUnit.usec ? amount : 0,
        ));
    }
  }

  DateTime nextInterval(
          {required DateTimeUnit onType, bool setToLastDay = false}) =>
      updateInterval(onType, 1, setToLastDay: setToLastDay);

  DateTime previousInterval(
          {required DateTimeUnit onType, bool setToLastDay = false}) =>
      updateInterval(onType, -1, setToLastDay: setToLastDay);

  /// Truncates the DateTime to the specified DateTimeUnit precision.
  DateTime truncate({DateTimeUnit atDateTimeUnit = DateTimeUnit.second}) {
    Set<DateTimeUnit> skipUnits = atDateTimeUnit.next?.sublist() ?? {};
    final m = isUtc ? DateTime.utc : DateTime.new;
    return m(
      skipUnits.contains(DateTimeUnit.year) ? 0 : year,
      skipUnits.contains(DateTimeUnit.month) ? 1 : month,
      skipUnits.contains(DateTimeUnit.day) ? 1 : day,
      skipUnits.contains(DateTimeUnit.hour) ? 0 : hour,
      skipUnits.contains(DateTimeUnit.minute) ? 0 : minute,
      skipUnits.contains(DateTimeUnit.second) ? 0 : second,
      skipUnits.contains(DateTimeUnit.msec) ? 0 : millisecond,
      skipUnits.contains(DateTimeUnit.usec) ? 0 : microsecond,
    );
  }
}
