import 'package:intl/intl.dart';

import '../constants/dt.dart';
import '../enums/datetime_ordering.dart';
import '../enums/datetime_unit.dart';
import '../extensions/datetime_num.dart';

class DateTimeDifference {
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

  DateTimeDifference({
    required DateTime startEvent,
    required DateTime endEvent,
    DateTimeUnit firstDateTimeUnit = DateTimeUnit.year,
  })  : finishDateTime = endEvent,
        startDateTime = startEvent,
        fieldSet = firstDateTimeUnit.sublist(),
        direction = DateTimeOrdering.direction(startEvent, endEvent) {
    if (direction == DateTimeOrdering.now) {
      _setItems(); // Set all items to null.
      return;
    }

    startEvent = DT.makeUtc(startEvent);
    endEvent = DT.makeUtc(endEvent);

    if (direction == DateTimeOrdering.before) {
      DateTime temp = startEvent;
      startEvent = endEvent;
      endEvent = temp;
    }

    final timeDifferences = _calculateTimeDifferences(startEvent, endEvent);
    _adjustNegativeValues(timeDifferences);

    if (!fieldSet.contains(DateTimeUnit.year)) {
      timeDifferences['months'] = (timeDifferences['months'] ?? 0) +
          timeDifferences['years']!.asMonths();
      timeDifferences['years'] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.month)) {
      timeDifferences['days'] = startEvent.difference(endEvent).inDays;
      timeDifferences['months'] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.day)) {
      timeDifferences['hours'] = startEvent.difference(endEvent).inHours;
      timeDifferences['days'] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.hour)) {
      timeDifferences['minutes'] = startEvent.difference(endEvent).inMinutes;
      timeDifferences['hours'] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.minute)) {
      timeDifferences['seconds'] = startEvent.difference(endEvent).inSeconds;
      timeDifferences['minutes'] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.second)) {
      timeDifferences['milliseconds'] =
          startEvent.difference(endEvent).inMilliseconds;
      timeDifferences['seconds'] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.msec)) {
      timeDifferences['microseconds'] =
          startEvent.difference(endEvent).inMicroseconds;
      timeDifferences['milliseconds'] = 0;
    }

    _setItems(
      years: timeDifferences['years'],
      months: timeDifferences['months'],
      days: timeDifferences['days'],
      hours: timeDifferences['hours'],
      minutes: timeDifferences['minutes'],
      seconds: timeDifferences['seconds'],
      milliseconds: timeDifferences['milliseconds'],
      microseconds: timeDifferences['microseconds'],
    );
  }

  Map<String, num> _calculateTimeDifferences(DateTime start, DateTime end) {
    return {
      'years': start.year - end.year,
      'months': start.month - end.month,
      'days': start.day - end.day,
      'hours': start.hour - end.hour,
      'minutes': start.minute - end.minute,
      'seconds': start.second - end.second,
      'milliseconds': start.millisecond - end.millisecond,
      'microseconds': start.microsecond - end.microsecond,
    };
  }

  void _adjustNegativeValues(Map<String, num> timeDifferences) {
    if (timeDifferences['microseconds']! < 0) {
      timeDifferences['milliseconds'] =
          (timeDifferences['milliseconds'] ?? 0) - 1;
      timeDifferences['microseconds'] =
          (timeDifferences['microseconds'] ?? 0) + DT.kUsecPerMsec;
    }
    if (timeDifferences['milliseconds']! < 0) {
      timeDifferences['seconds'] = (timeDifferences['seconds'] ?? 0) - 1;
      timeDifferences['milliseconds'] =
          (timeDifferences['milliseconds'] ?? 0) + DT.kMsecPerSecond;
    }
    if (timeDifferences['seconds']! < 0) {
      timeDifferences['minutes'] = (timeDifferences['minutes'] ?? 0) - 1;
      timeDifferences['seconds'] =
          (timeDifferences['seconds'] ?? 0) + DT.kSecondsPerMinute;
    }
    if (timeDifferences['minutes']! < 0) {
      timeDifferences['hours'] = (timeDifferences['hours'] ?? 0) - 1;
      timeDifferences['minutes'] =
          (timeDifferences['minutes'] ?? 0) + DT.kMinutesPerHour;
    }
    if (timeDifferences['hours']! < 0) {
      timeDifferences['days'] = (timeDifferences['days'] ?? 0) - 1;
      timeDifferences['hours'] =
          (timeDifferences['hours'] ?? 0) + DT.kHoursPerDay;
    }
    if (timeDifferences['days']! < 0) {
      timeDifferences['months'] = (timeDifferences['months'] ?? 0) - 1;

      DateTime orderedDateTime = (direction == DateTimeOrdering.before)
          ? finishDateTime
          : startDateTime;
      final numberOfDaysInMonth =
          DateTime(orderedDateTime.year, orderedDateTime.month, 0).day;
      timeDifferences['days'] =
          (timeDifferences['days'] ?? 0) + numberOfDaysInMonth;
    }
    if (timeDifferences['months']! < 0) {
      timeDifferences['years'] = (timeDifferences['years'] ?? 0) - 1;
      timeDifferences['months'] =
          (timeDifferences['months'] ?? 0) + DT.kMonthsPerYear;
    }
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
    this.years = fieldSet.contains(DateTimeUnit.year) ? years : null;
    this.months = fieldSet.contains(DateTimeUnit.month) ? months : null;
    this.days = fieldSet.contains(DateTimeUnit.day) ? days : null;
    this.hours = fieldSet.contains(DateTimeUnit.hour) ? hours : null;
    this.minutes = fieldSet.contains(DateTimeUnit.minute) ? minutes : null;
    this.seconds = fieldSet.contains(DateTimeUnit.second) ? seconds : null;
    msecs = fieldSet.contains(DateTimeUnit.msec) ? milliseconds : null;
    usecs = fieldSet.contains(DateTimeUnit.usec) ? microseconds : null;
  }
}
