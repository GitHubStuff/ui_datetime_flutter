import 'package:flutter/material.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';

import 'datetime_theme_data.dart';

/// The theme for the DateTimePicker.
class DateTimePickerTheme extends InheritedTheme {
  /// Constructor for DateTimePickerTheme.
  const DateTimePickerTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// Constructor for DateTimePickerTheme.
  static DateTimeThemeData of(BuildContext context) {
    // Flutter feature: if a widget is the child of DateTimerPickerTheme, it will return use
    // that theme, otherwise it looks for DateTimeThemeData in a theme extention.
    final theme =
        context.dependOnInheritedWidgetOfExactType<DateTimePickerTheme>();
    if (theme != null) return theme.data;
    final data = context.theme.extension<DateTimeThemeData>();
    return data ??
        (context.theme.brightness == Brightness.dark
            ? DateTimeThemeData.darkIndustrial()
            : DateTimeThemeData.lightIndustrial());
  }

  /// The data for the DateTimePickerTheme.
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
