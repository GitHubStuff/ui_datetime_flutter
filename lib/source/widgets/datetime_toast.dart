import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/dt.dart';
import '../enums/datetime_toast_position.dart';
import 'package:oktoast/oktoast.dart' as ok_toast;

const _kDefaultDuration = Duration(milliseconds: 2750); // 2.75 seconds

class DateTimeToast {
  static Widget setUp({required Widget child}) =>
      ok_toast.OKToast(child: child);

  static void show({
    required String message,
    DateTime? dateTime,
    DateTimeToastPosition position = DateTimeToastPosition.bottom,
    Duration duration = _kDefaultDuration,
    String formatString = DT.kDateTimeFormat,
  }) {
    dateTime = DT.makeLocal(dateTime);
    String formattedDateTime = DateFormat(formatString).format(dateTime);
    ok_toast.showToast(
      '$formattedDateTime\n$message',
      duration: duration,
      position: position.okToastPosition,
    );
  }
}
