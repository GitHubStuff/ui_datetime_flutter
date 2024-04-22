import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/dt.dart';
import '../enums/datetime_toast_position.dart';
import 'package:oktoast/oktoast.dart' as ok;

/// A utility class for displaying toast notifications with date and time information.
///
/// The [DateTimeToast] class provides a simple way to show toast notifications
/// with a formatted date and time along with a message. It utilizes the `oktoast`
/// package for displaying notifications.
///
/// NOTE: Setup is required before using the DateTimeToast class. This can be done
/// by calling the [DateTimeToast.setUp] method in the main method of your app.
///
/// Example usage:
///
/// ```dart
/// DateTimeToast().show(
///   message: "Meeting Reminder",
///   dateTime: DateTime(2024, 1, 15, 14, 30),
///   duration: Duration(seconds: 3),
///   position: DateTimeToastPosition.bottom,
/// );
/// ```

const _kDefaultDuration = Duration(milliseconds: 2750); // 2.75 seconds

class DateTimeToast {
  static Widget setUp({required Widget child}) => ok.OKToast(child: child);

  /// Displays a toast notification with date and time information.
  ///
  /// - [message]: The message to be displayed in the toast.
  /// - [dateTime]: The date and time to be included in the toast (default is the current system time).
  /// - [position]: The position of the toast (top, center, or bottom) (default is bottom).
  /// - [duration]: The duration for which the toast should be displayed (default is 2750 milliseconds).
  /// - [formatString]: The format string to use for formatting the date and time (default is 'EEE d-MMM-yyyy h:mm:ss a').
  /// - [toaster]: The toaster widget to use for displaying the toast (default is okToast.OKToast).
  void show({
    required String message,
    DateTime? dateTime,
    DateTimeToastPosition position = DateTimeToastPosition.bottom,
    Duration duration = _kDefaultDuration,
    String formatString = DT.kDateTimeFormat,
    dynamic toaster = ok.OKToast,
  }) {
    dateTime = DT.makeLocal(dateTime);
    String formattedDateTime = DateFormat(formatString).format(dateTime);
    switch (toaster) {
      case const (ok.OKToast):
        ok.showToast(
          '$formattedDateTime\n$message',
          duration: duration,
          position: position.okToastPosition,
        );
      default:
        throw Exception('Unknown toaster: $toaster');
    }
  }
}
