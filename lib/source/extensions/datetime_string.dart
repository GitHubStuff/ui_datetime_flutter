// ignore_for_file: public_member_api_docs

import '../enums/datetime_unit.dart';

/// Extensions on 'String' to provide additional functionality for datetime strings/options.
extension DateTimeString on String {
  DateTimeUnit? dateTimeUnitOrNull() {
    for (final unit in DateTimeUnit.values) {
      if (unit.name.toLowerCase() == toLowerCase()) return unit;
    }
    return null;
  }

  String formattedDateTime(DateTime? dateTimeValue) {
    final dateTime = dateTimeValue ?? DateTime.now();
    // Mapping of format characters to corresponding date/time values
    final formatMap = <String, String>{
      'yyyy': dateTime.year.toString(),
      'yy': dateTime.year.toString().substring(2),
      'MM': dateTime.month.toString().padLeft(2, '0'),
      'M': dateTime.month.toString(),
      'dd': dateTime.day.toString().padLeft(2, '0'),
      'd': dateTime.day.toString(),
      'HH': dateTime.hour.toString().padLeft(2, '0'),
      'H': dateTime.hour.toString(),
      'mm': dateTime.minute.toString().padLeft(2, '0'),
      'm': dateTime.minute.toString(),
      'ss': dateTime.second.toString().padLeft(2, '0'),
      's': dateTime.second.toString(),
    };

    // Replace format characters with actual date/time values
    var formattedString = this;
    formatMap.forEach((key, value) {
      formattedString = formattedString.replaceAll(key, value);
    });

    return formattedString;
  }
}
