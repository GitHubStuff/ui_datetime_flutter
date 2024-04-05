# DateTimeToast

A utility class for displaying toast notifications with date and time information.

The DateTimeToast class provides a simple way to show toast notifications with a formatted date and time along with a message. It utilizes the oktoast package for displaying notifications.

NOTE: Setup is required before using the DateTimeToast class. This can be done by calling the DateTimeToast.setUp method in the main method of your app.

## Example Usage

```dart
DateTimeToast().show(
  message: "Meeting Reminder",
  dateTime: DateTime(2024, 1, 15, 14, 30),
  duration: Duration(seconds: 3),
  position: DateTimeToastPosition.bottom,
);
```

## Installation


