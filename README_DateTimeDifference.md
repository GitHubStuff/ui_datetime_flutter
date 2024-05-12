# DateTimeDifference Utility Class

A Dart utility class for calculating precise intervals between two DateTime objects, offering customizability with various time units and accounting for different date directions (e.g., past, present, future).

## Features

- Calculate time intervals with precision up to the microsecond.
- Support for various units: years, months, days, hours, minutes, seconds, milliseconds, and microseconds.
- Direction-sensitive calculations, determining if the interval is before, now, or after the given start date.

## Installation

Add to pubspec.yaml:

```yaml
dependencies:
  ui_datetime_flutter:
    git: https://github.com/GitHubStuff/ui_datetime_flutter.git
```

## Usage

To use this utility, create an instance of `DateTimeDifference` by specifying the start and end DateTime objects, and optionally the smallest unit of time you are interested in.

```dart
import 'package:ui_datetime_flutter/date_time_interval.dart';

void main() {
  DateTimeDifference interval = DateTimeDifference(
    startEvent: DateTime(2023, 1, 15),
    endEvent: DateTime(2024, 1, 15),
    firstDateTimeUnit: DateTimeUnit.month,
  );
  print(interval.toString()); Output: "12 0 00:00:00"
}
```

## Documentation

The DateTimeDifference class allows for flexible date interval calculation:

### Parameters

- startEvent: The starting DateTime for the interval.
- endEvent: The ending DateTime for the interval.
- firstDateTimeUnit: The smallest unit of time to consider in calculations (default is DateTimeUnit.year).

### Methods

-toString(): Returns a string representation of the interval, formatted according to the specified units and directions.

## Contributions

Contributions are welcome. Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Finally

Be kind to each other!
