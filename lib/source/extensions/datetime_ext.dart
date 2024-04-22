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
        DT.kDaysPlaceholder,
        DT.kDaysJanuary,
        isLeapYear() ? DT.kDaysFebruaryLeap : DT.kDaysFebruary,
        DT.kDaysMarch,
        DT.kDaysApril,
        DT.kDaysMay,
        DT.kDaysJune,
        DT.kDaysJuly,
        DT.kDaysAugust,
        DT.kDaysSeptember,
        DT.kDaysOctober,
        DT.kDaysNovember,
        DT.kDaysDecember,
      ][month];

  /// Returns a new DateTime with the given number of months added.
  DateTime addToMonth(num months, {bool setToLastDay = true}) {
    DateTime.january;
    DateTime returnDateTime = toUtc();
    if (months == 0) return this;
    if (months < 0) {
      while (months < 0) {
        months++;
        returnDateTime = returnDateTime._subtractMonth(
          returnDateTime,
          setToLastDay: setToLastDay,
        );
      }
    } else {
      while (months > 0) {
        months--;
        returnDateTime = returnDateTime._addMonth(
          returnDateTime,
          setToLastDay: setToLastDay,
        );
      }
    }
    return returnDateTime;
  }

  /// Returns a new DateTime with the given number of years added.
  DateTime addToYear(int years, {bool setToLastDay = true}) => addToMonth(
        years * DateTime.monthsPerYear,
        setToLastDay: setToLastDay,
      );

  /// Returns the Interval between this DateTime and a target DateTime.
  DateTimeInterval interval(
          {DateTime? targetDateTime,
          DateTimeUnit roundedTo = DateTimeUnit.year}) =>
      DateTimeInterval(
        startEvent: this,
        endEvent: targetDateTime ?? DateTime.now(),
        firstDateTimeUnit: roundedTo,
      );

  /// Returns true/false if the year is a leap year.
  bool isLeapYear() => (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  /// Returns true/false if the DateTime is the last day of the month.
  bool isLastDayOfMonth() => day == daysInMonth;

  /// Returns a new DateTime representing the next interval based on DateTimeUnit.
  DateTime nextInterval(
          {required DateTimeUnit onType, bool setToLastDay = true}) =>
      _updateInterval(onType: onType, setToLastDay: setToLastDay, amount: 1);

  /// Returns a new DateTime representing the previous interval based on DateTimeUnit.
  DateTime previousInterval(
          {required DateTimeUnit onType, bool setToLastDay = true}) =>
      _updateInterval(onType: onType, setToLastDay: setToLastDay, amount: -1);

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

  DateTime _updateInterval(
      {required DateTimeUnit onType,
      required bool setToLastDay,
      required int amount}) {
    switch (onType) {
      case DateTimeUnit.year:
        return addToYear(amount, setToLastDay: setToLastDay);
      case DateTimeUnit.month:
        return addToMonth(amount, setToLastDay: setToLastDay);
      case DateTimeUnit.day:
        return add(Duration(days: amount));
      case DateTimeUnit.hour:
        return add(Duration(hours: amount));
      case DateTimeUnit.minute:
        return add(Duration(minutes: amount));
      case DateTimeUnit.second:
        return add(Duration(seconds: amount));
      case DateTimeUnit.msec:
        return add(Duration(milliseconds: amount));
      case DateTimeUnit.usec:
        return add(Duration(microseconds: amount));
    }
  }

  DateTime _addMonth(DateTime start, {bool setToLastDay = true}) {
    int newMonth = start.month + 1;
    final int newYear =
        start.year + (newMonth > DateTime.monthsPerYear ? 1 : 0);
    newMonth = newMonth > DateTime.monthsPerYear ? DateTime.january : newMonth;
    setToLastDay = setToLastDay && start.day == start.daysInMonth;
    int newDay =
        setToLastDay ? DateTime(newYear, newMonth + 1, 0).day : start.day;

    return DateTime.utc(
      newYear,
      newMonth,
      newDay,
      start.hour,
      start.minute,
      start.second,
      start.millisecond,
      start.microsecond,
    );
  }

  DateTime _subtractMonth(DateTime back, {bool setToLastDay = true}) {
    int newMonth = back.month - 1;
    final int newYear = newMonth < DateTime.january ? back.year - 1 : back.year;
    newMonth = newMonth < DateTime.january ? DateTime.monthsPerYear : newMonth;
    final int newDay =
        setToLastDay ? DateTime(newYear, newMonth + 1, 0).day : back.day;
    return DateTime.utc(
      newYear,
      newMonth,
      newDay,
      back.hour,
      back.minute,
      back.second,
      back.millisecond,
      back.microsecond,
    );
  }
}
