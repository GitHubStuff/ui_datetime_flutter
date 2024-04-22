# DateTime Extensions for Dart

This Dart package provides an extension on the `String` class to facilitate date and time formatting and parsing based on custom string inputs.

## Features

- **DateTime Parsing:** Convert string representations of datetime units into `DateTimeUnit` enum values.
- **DateTime Formatting:** Format `DateTime` objects into string representations based on specified patterns.

## Usage

Parsing DateTime Units
You can parse strings to check if they correspond to any DateTimeUnit:

```dart
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  String unitStr = "year";
  DateTimeUnit? unit = unitStr.dateTimeUnitOrNull();
  print(unit);  // Output: DateTimeUnit.year (if "year" is a valid enum name)
}

// Formatting DateTimes
// Format a DateTime object based on a string pattern:
void main() {
  DateTime now = DateTime.now();
  String format = "yyyy-MM-dd HH:mm:ss";
  String formattedDate = format.formattedDateTime(now);
  print(formattedDate);  // Output: e.g., 2024-04-12 14:23:05
}
```

## Contributing

Contributions to this project are welcome. Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Finally

Be kind to each other!
