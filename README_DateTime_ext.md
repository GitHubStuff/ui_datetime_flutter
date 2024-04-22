# DateTime Extension for Flutter

## Overview

This Dart package extends the `DateTime` class with additional utility methods that simplify date manipulation and formatting within a Flutter application. This extension leverages the `intl` package for formatting dates and provides methods for adding time intervals, checking leap years, and much more.

## Features

### Formatting Dates

- **formatted:** Format a `DateTime` object to a string based on the given date-time format. This method also allows the date to be treated as UTC or local time.

### Date Information

- **daysInMonth:** Calculate the number of days in the month, considering leap years.
- **isLeapYear:** Determine if the year of the `DateTime` instance is a leap year.
- **isLastDayOfMonth:** Check if the `DateTime` instance falls on the last day of its month.

### Date Manipulation

- **addToMonth:** Adds a specified number of months to the date, optionally setting the day to the last day of the month.
- **addToYear:** Adds a specified number of years to the date, this is a convenience method that leverages `addToMonth`.
- **nextInterval:** Advances the date by one unit of time based on the specified `DateTimeUnit`, which can be set to the last day of the time unit.
- **previousInterval:** Moves the date back by one unit of time based on the specified `DateTimeUnit`, which can be set to the last day of the time unit.
- **truncate:** Truncates the `DateTime` to a specified precision, effectively zeroing smaller components.

### Interval Calculation

- **interval:** Calculates the time interval between the current `DateTime` instance and another specified `DateTime`, rounding to the nearest specified `DateTimeUnit`.

## Getting Started

To use these extensions in your Flutter project, simply import the package:

```dart
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

DateTime now = DateTime.now();
print(now.formatted(format: "yyyy-MM-dd"));
print("Days in month: ${now.daysInMonth}");
DateTime nextMonth = now.addToMonth(1);
```

## Conclusion

This DateTime extension provides robust tools for handling complex date and time manipulation tasks in Flutter applications, simplifying development and enhancing code readability.

## Finally

Be kind to each other!
