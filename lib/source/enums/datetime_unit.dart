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

  /// Returns the next DateTimeUnit from the current DateTimeUnit
  /// If the current DateTimeUnit is the last one, it will return null
  DateTimeUnit? get next {
    if (this == usec) return null;
    final index = DateTimeUnit.values.indexOf(this);
    return DateTimeUnit.values[index + 1];
  }

  /// Checks if the current DateTimeUnit is in the provided exclusion set
  /// If it is, an ArgumentError is thrown
  //TODO: Uncomment this method after testing

  // void checkPrecision({
  //   Set<DateTimeUnit> exclusionSet = const {
  //     DateTimeUnit.msec,
  //     DateTimeUnit.usec,
  //   },
  // }) {
  //   if (exclusionSet.contains(this)) {
  //     throw ArgumentError('$name cannot be used as a DateTimeUnit');
  //   }
  // }

  /// Returns a set of DateTimeUnits from the current DateTimeUnit to the last DateTimeUnit
  Set<DateTimeUnit> sublist() {
    final index = DateTimeUnit.values.indexOf(this);
    return Set<DateTimeUnit>.from(DateTimeUnit.values.sublist(index));
  }
}
