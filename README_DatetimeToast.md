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

```yaml
dependencies:
  ui_datetime_flutter:
    git: https://github.com/GitHubStuff/ui_datetime_flutter.git
```

## Setup

Call the ```setup``` in the main.dart at the root of the widget tree:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ModularApp(
      module: AppModule(),
      child: DateTimeToast.setUp(child: const MyApp()),
    ),
  );
}
```

## API Reference

```dart
DateTimeToast().show(...);
```

Displays a toast notification with date and time information.

Parameters:
-message: The message to be displayed in the toast.
-dateTime: The date and time to be included in the toast (default is the current system time).
-position: The position of the toast (top, center, or bottom) (default is bottom).
-duration: The duration for which the toast should be displayed (default is 2750 milliseconds).
-formatString: The format string to use for formatting the date and time (default is 'EEE d-MMM-yyyy h:mm:ss a').
-toaster: The toaster widget to use for displaying the toast (default is okToast.OKToast).

Default Values

-duration: 2750 milliseconds
-formatString: 'EEE d-MMM-yyyy h:mm:ss a'
-toaster: okToast.OKToast

## License

2004 Apache License see [LICENSE.txt](LICENSE.txt)

## Finally

Be kind to each other!
