/// Enum for DateTime fields/properties
library;
// ignore_for_file: public_member_api_docs

enum DateTimeUnit {
  year,
  month,
  day,
  hour,
  minute,
  second,
  msec,
  usec;

  /// Returns the next DateTimeUnit from the current DateTimeUnit
  /// If the current DateTimeUnit is the last one, it will return null
  DateTimeUnit? get next {
    if (this == usec) return null;
    final index = DateTimeUnit.values.indexOf(this);
    return DateTimeUnit.values[index + 1];
  }

  /// Returns a set of DateTimeUnits from the current DateTimeUnit to the last DateTimeUnit
  /// Helper method to get a sublist of DateTimeUnits
  Set<DateTimeUnit> sublist() {
    final index = DateTimeUnit.values.indexOf(this);
    return Set<DateTimeUnit>.from(DateTimeUnit.values.sublist(index));
  }
}
