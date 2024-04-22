import 'package:intl/intl.dart';

import '../constants/dt.dart';
import '../enums/datetime_ordering.dart';
import '../enums/datetime_unit.dart';
import '../extensions/datetime_num.dart';

/// A utility class for calculating the interval between two DateTime objects.

///
/// The [DateTimeInterval] class calculates the interval between two DateTime objects
/// with customizable precision, including years, months, days, hours, minutes,
/// seconds, milliseconds, and microseconds. It takes into account the direction
/// of the interval, whether it's "before," "now," or "after" the startDateTime.
///
/// Example usage:
///
/// ```dart
/// DateTimeInterval interval = DateTimeInterval(
///   startEvent: DateTime(2023, 1, 15),
///   endEvent: DateTime(2024, 1, 15),
///   firstDateTimeUnit: DateTimeUnit.month,
/// );
/// print(interval.toString()); // "12 months"
/// ```

class DateTimeInterval {
  late final DateTime finishDateTime;
  late final DateTime startDateTime;
  late final num? years;
  late final num? months;
  late final num? days;
  late final num? hours;
  late final num? minutes;
  late final num? seconds;
  late final num? msecs;
  late final num? usecs;
  late final DateTimeOrdering direction;
  late final Set<DateTimeUnit> fieldSet;

  /// Creates a DateTimeInterval instance.
  ///
  /// - [startEvent]: The starting DateTime for the interval.
  /// - [endEvent]: The ending DateTime for the interval.
  /// - [firstDateTimeUnit]: Where the interval value  (default is DateTimeUnit.year).
  DateTimeInterval({
    required DateTime startEvent,
    required DateTime endEvent,
    DateTimeUnit firstDateTimeUnit = DateTimeUnit.year,
  })  : finishDateTime = endEvent,
        startDateTime = startEvent,
        fieldSet = firstDateTimeUnit.sublist(),
        direction = DateTimeOrdering.direction(startEvent, endEvent) {
    // Equal dates
    if (direction == DateTimeOrdering.now) {
      _setItems(); // Set all items to null.
      return;
    }

    /// Ensure that both dates are in UTC.
    startEvent = DT.makeUtc(startEvent);
    endEvent = DT.makeUtc(endEvent);

    /// Swap dates if direction is [before], so that negative values are not calculated
    /// for the purpose of normalizing the count, to get the correct count.
    if (direction == DateTimeOrdering.before) {
      DateTime temp = startEvent;
      startEvent = endEvent;
      endEvent = temp;
    }

    num yearCount = startEvent.year - endEvent.year;
    num monthCount = startEvent.month - endEvent.month;
    num dayCount = startEvent.day - endEvent.day;
    num hourCount = startEvent.hour - endEvent.hour;
    num minuteCount = startEvent.minute - endEvent.minute;
    num secondCount = startEvent.second - endEvent.second;
    num milliCount = startEvent.millisecond - endEvent.millisecond;
    num microCount = startEvent.microsecond - endEvent.microsecond;

    if (microCount < 0) {
      milliCount--;
      microCount += DT.kUsecPerMsec;
    }
    if (milliCount < 0) {
      secondCount--;
      milliCount += DT.kMsecPerSecond;
    }
    if (secondCount < 0) {
      minuteCount--;
      secondCount += DT.kSecondsPerMinute;
    }
    if (minuteCount < 0) {
      hourCount--;
      minuteCount += DT.kMinutesPerHour;
    }
    if (hourCount < 0) {
      dayCount--;
      hourCount += DT.kHoursPerDay;
    }

    if (dayCount < 0) {
      monthCount--;
      final numberOfDaysInMonth =
          DateTime(startEvent.year, startEvent.month, 0).day;
      dayCount += numberOfDaysInMonth;
    }

    if (monthCount < 0) {
      yearCount--;
      monthCount += DT.kMonthsPerYear;
    }

    if (!fieldSet.contains(DateTimeUnit.year)) {
      monthCount += yearCount.asMonths();
      yearCount = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.month)) {
      dayCount = startEvent.difference(endEvent).inDays;
      monthCount = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.day)) {
      hourCount = startEvent.difference(endEvent).inHours;
      dayCount = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.hour)) {
      minuteCount = startEvent.difference(endEvent).inMinutes;
      hourCount = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.minute)) {
      secondCount = startEvent.difference(endEvent).inSeconds;
      minuteCount = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.second)) {
      milliCount = startEvent.difference(endEvent).inMilliseconds;
      secondCount = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.msec)) {
      microCount = startEvent.difference(endEvent).inMicroseconds;
      milliCount = 0;
    }
    _setItems(
      years: yearCount,
      months: monthCount,
      days: dayCount,
      hours: hourCount,
      minutes: minuteCount,
      seconds: secondCount,
      milliseconds: milliCount,
      microseconds: microCount,
    );
  }

  @override
  String toString() {
    if (direction == DateTimeOrdering.now) return '00:00:00';
    String result = '';
    if (usecs != null && usecs! > 0) {
      final int milliSeconds = msecs!.toInt() * 1000;
      result += ".${NumberFormat('000000').format(milliSeconds)}";
    }
    if (result.isEmpty && msecs != null && msecs! > 0) {
      result += ".${NumberFormat('000').format(msecs)}";
    }
    result +=
        "${NumberFormat('00').format(hours ?? 0)}:${NumberFormat('00').format(minutes ?? 0)}:${NumberFormat('00').format(seconds ?? 0)}";
    final months = NumberFormat('00').format(this.months ?? 0);
    final days = NumberFormat('00').format(this.days ?? 0);

    if (years != null && years! > 0) {
      result = "$years $months $days $result";
    } else if (this.months != null && this.months! > 0) {
      result = "${this.months} $days $result";
    } else if (this.days != null && this.days! > 0) {
      result = "${this.days} $result";
    }
    if (direction == DateTimeOrdering.after) result = "-$result";

    return result;
  }

  void _setItems({
    num? years,
    num? months,
    num? days,
    num? hours,
    num? minutes,
    num? seconds,
    num? milliseconds,
    num? microseconds,
  }) {
    this.years = (fieldSet.contains(DateTimeUnit.year)) ? years : null;
    this.months = (fieldSet.contains(DateTimeUnit.month)) ? months : null;
    this.days = (fieldSet.contains(DateTimeUnit.day)) ? days : null;
    this.hours = (fieldSet.contains(DateTimeUnit.hour)) ? hours : null;
    this.minutes = (fieldSet.contains(DateTimeUnit.minute)) ? minutes : null;
    this.seconds = (fieldSet.contains(DateTimeUnit.second)) ? seconds : null;
    msecs = (fieldSet.contains(DateTimeUnit.msec)) ? milliseconds : null;
    usecs = (fieldSet.contains(DateTimeUnit.usec)) ? microseconds : null;
  }
}
