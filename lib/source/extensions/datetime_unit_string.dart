import '../enums/datetime_unit.dart';

extension DateTimeUnitString on String {
  DateTimeUnit dateTimeUnit() {
    for (DateTimeUnit unit in DateTimeUnit.values) {
      if (unit.name.toLowerCase() == toLowerCase()) return unit;
    }
    for (DateTimeUnit unit in DateTimeUnit.values) {
      // ignore: avoid_print
      print('Allowed: ${unit.name}');
    }
    throw ArgumentError('Invalid DateTimeUnit $this');
  }
}
