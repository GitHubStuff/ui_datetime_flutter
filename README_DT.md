# DateTime Utilities

This module provides utilities for managing and manipulating date and time objects in Dart.

## Features

- **Local and UTC DateTime Creation**: Create DateTime objects in either local or UTC formats with options for truncating to different precisions.

- **Constant Values**: Includes constants for common time units and typical days in each month, facilitating calculations and conversions without hard-coding values.

## Installation

```yaml
dependencies:
  ui_datetime_flutter:
    git: https://github.com/GitHubStuff/ui_datetime_flutter.git
```

## Usage

- DT.makeLocal(dateTime, truncateAt): Creates a local DateTime object. You can optionally specify a DateTime object and the precision to truncate it to.
- DT.makeUtc(dateTime, truncateAt): Similar to makeLocal but creates a UTC DateTime object.

```dart
DateTime now = DT.makeLocal(null, truncateAt: DateTimeUnit.minute);
```

This will create a DateTime object representing the current time, truncated at the nearest minute.

## Constants

The module defines a number of constants for time calculations:

- kMonthsPerYear, kHoursPerDay, etc.: Use these for converting between different time units.
- kDaysJanuary, kDaysFebruary, etc.: These can be helpful for operations involving specific months.

## Contributions

Contributions are welcome! Please feel free to submit pull requests or create issues for bugs and feature requests.

## License

[MIT License](LICENSE.txt)

## Finally

Be kind to each other!
