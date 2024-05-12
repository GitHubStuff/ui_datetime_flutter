import 'package:flutter/material.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';

import 'datetime_theme_data.dart';

class DateTimePickerTheme extends InheritedTheme {
  static DateTimeThemeData of(BuildContext context) {
    // Flutter feature: if a widget is the child of DateTimerPickerTheme, it will return use
    // that theme, otherwise it looks for DateTimeThemeData in a theme extention.
    DateTimePickerTheme? theme =
        context.dependOnInheritedWidgetOfExactType<DateTimePickerTheme>();
    if (theme != null) return theme.data;
    DateTimeThemeData? data = context.theme.extension<DateTimeThemeData>();
    return data ??
        (context.theme.brightness == Brightness.dark
            ? DateTimeThemeData.darkIndustrial()
            : DateTimeThemeData.lightIndustrial());
  }

  const DateTimePickerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final DateTimeThemeData data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return DateTimePickerTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DateTimePickerTheme oldWidget) {
    return data != oldWidget.data;
  }
}
