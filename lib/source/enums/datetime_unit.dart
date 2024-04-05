/// Enum for DateTime fields/properties
enum DateTimeUnit {
  year,
  month,
  day,
  hour,
  minute,
  second,
  msec,
  usec;

  /// Returns a set of DateTimeUnits from the current DateTimeUnit to the last DateTimeUnit
  Set<DateTimeUnit> setFrom() {
    final index = DateTimeUnit.values.indexOf(this);
    return Set<DateTimeUnit>.from(DateTimeUnit.values.sublist(index));
  }
}
