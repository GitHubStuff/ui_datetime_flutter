# DateTimeString Extension for Dart

The `DateTimeString` extension adds useful date and time formatting capabilities to the Dart `String` class. This extension provides methods to parse strings into `DateTimeUnit` enums and to format `DateTime` objects into a string according to a template provided by the string itself.

## Features

- **`dateTimeUnitOrNull()`**: Converts the string into a `DateTimeUnit` if the string matches any of the enum's names, case-insensitively.
- **`formattedDateTime(DateTime? dateTime)`**: Formats a given `DateTime` object (or the current date and time if none is provided) according to the format specified by the string.

## Installation

To use this extension in your project, simply include the file containing the extension in your Dart project. Make sure the Dart file is correctly part of your project and that it's imported where you intend to use it.

## Usage

### Parsing DateTimeUnit from String

You can convert a string to a `DateTimeUnit` by calling `dateTimeUnitOrNull()`. This method returns `null` if the string does not correspond to any `DateTimeUnit`.

Example:

```dart
String unitString = "days";
DateTimeUnit? unit = unitString.dateTimeUnitOrNull();
print(unit); // Output: DateTimeUnit.days
```

#### Formatting DateTime

You can format a DateTime object using a string as the template. The template string should contain format characters that are replaced by corresponding date/time values.

Example:

```dart
String format = "yyyy-MM-dd HH:mm:ss";
String formattedDate = format.formattedDateTime(DateTime.now());
print(formattedDate); // Output: 2024-04-12 15:23:30 (example output, will vary)
```

Supported Format Characters

-yyyy: Four digit year
-yy: Last two digits of the year
-MM: Two digit month (with leading zero)
-M: Month without leading zero
-dd: Two digit day (with leading zero)
-d: Day without leading zero
-HH: Two digit hour (24-hour format, with leading zero)
-H: Hour in 24-hour format without leading zero
-mm: Two digit minute (with leading zero)
-m: Minute without leading zero
-ss: Two digit second (with leading zero)
-s: Second without leading zero

## Finally

Be kind to each other.
