import '../enums/datetime_unit.dart';

extension DateTimeString on String {
  DateTimeUnit? dateTimeUnitOrNull() {
    for (DateTimeUnit unit in DateTimeUnit.values) {
      if (unit.name.toLowerCase() == toLowerCase()) return unit;
    }
    return null;
  }

  String formattedDateTime(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    // Mapping of format characters to corresponding date/time values
    final Map<String, String> formatMap = {
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
    String formattedString = this;
    formatMap.forEach((key, value) {
      formattedString = formattedString.replaceAll(key, value);
    });

    return formattedString;
  }
}
