# UIDateTimeFlutter

A package of widgets, classes, constants, enums, and helper methods related to DateTime

## Installation

pubspec.yaml

```yaml
dependencies:
  ui_datetime_flutter:
    git: https://github.com/GitHubStuff/ui_datetime_flutter.git
```

## Features

### Classes

#### DateTimeInterval

A super enhanced ```Duration()``` class that includes, years, months, days, hours, minutes, seconds, mseconds, useconds.

See [README_DateTimeInterval.md](README_DateTimeInterval.md) for details.

### Constants

#### DT

A raper class (DT) for constants used in Duration, Amounts, and toLocal() and toUTC() creation.

See [README_DT.md](README_DT.md) for details.

### Enums

#### DateTimeOrdering

Enhanced enum helper/wrapper for determining the order of two dates.

See [datetime_ordering.dart](/lib/source/enums/datetime_ordering.dart) for content.

#### DateTimeToastPosition

Enum used by widget that displays a toast message with a DateTime included in the header.

See [datetime_toast_position.dart](/lib/source/enums/datetime_toast_position.dart) for content.

#### DateTimeUnit

Enum to expand DateTime items to include years and months.

See [datetime_unit.dart](/lib/source/enums/datetime_unit.dart) for content.

### Extensions

#### DateTimeExt

This Dart package extends the `DateTime` class with additional utility methods that simplify date manipulation and formatting within a Flutter application. This extension leverages the `intl` package for formatting dates and provides methods for adding time intervals, checking leap years, and much more.

See [README_DateTime_ext.md](README_DateTime_ext.md) for details.

#### DateTimeString

The `DateTimeString` extension adds useful date and time formatting capabilities to the Dart `String` class. This extension provides methods to parse strings into `DateTimeUnit` enums and to format `DateTime` objects into a string according to a template provided by the string itself.

See [README_DateTime_String.md](README_DateTime_String.md) for details.

### State Management using [flutter_bloc](https://pub.dev/packages/flutter_bloc)

A [Cubit](https://pub.dev/packages/flutter_bloc) that manages the state of a repeating alarm.

The alarm can be configured to trigger at a specific time and optionally
repeat at a specified interval.

```dart
//Creates an alarm cubit set to fire once in one hour
RepeatingAlarmCubit rac = RepeatingAlarmCubit(alarmDateTime:DateTime.now().add(Duration(hours: 1)))..start();

//Creates an alarm cubit set to fire once in two hours.
//and emits every five minutes,
Duration repeatEvery = Duration(minutes: 5);
RepeatingAlarmCubit bac = RepeatingAlarmCubit(alarmDateTime: DateTime.now().add(Duration(hours: 2)),
                                              repeatInteval: repeatEvery)..start();

rac.stopAlarm(); // Cancels the alarm
```

### Widgets

#### UIDateTimePicker

Uses scroll wheels to display compact date/time picker that uses less space and an intutive user experience.

See: [README_DateTimePicker.md](README_DateTimePicker.md) for details.

### DateTimeToast

Display a toast message at the top, middle, or bottom of the screen with included DateTime stamp. See: [README_DatetimeToast.md](README_DatetimeToast.md) for details.

### UISelectDateTimeUnit

Helper widget that displays a radio button group for Year, Month, Day, Hour, Minute, Second, and optionally Millsecond and MicroSecond. This simplifies selecting of unit of time for forms,
selectors, etc. See: [README_UISelectDateTimeUnit.md](README_UISelectDateTimeUnit.md) for details.

## Finally

Be kind to each other!
