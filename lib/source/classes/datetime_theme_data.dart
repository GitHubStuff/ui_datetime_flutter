import 'package:flutter/material.dart';

// Color Definitions
const Color _textLight = Colors.white;
const Color _textDark = Color(0xffFFEB3B);
// Earth Theme
const Color _pickerBackgroundLightEarth = Color(0xFFe2725b);
const Color _pickerBackgroundDarkEarth = Color(0xFFCB4F3A);
const Color _dateBackgroundLightEarth = Color(0xffFFEB3B);
const Color _dateBackgroundDarkEarth = Color(0xff394D2E);
const Color _timeBackgroundLightEarth = Color(0xffF4DECB);
const Color _timeBackgroundDarkEarth = Color(0xff5A4E44);
// Industrial Theme
const Color _pickerBackgroundLightIndustrial = Color(0xFF2A3439);
const Color _pickerBackgroundDarkIndustrial = Color(0xFF222222);
const Color _dateBackgroundLightIndustrial = Color(0xff333840);
const Color _dateBackgroundDarkIndustrial = Color(0xff191970);
const Color _timeBackgroundLightIndustrial = Color(0xff4682B4);
const Color _timeBackgroundDarkIndustrial = Color(0xff0A1A1A);

TextStyle _createTextStyle(Color color, double fontSize) => TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

class DateTimeThemeData extends ThemeExtension<DateTimeThemeData> {
  factory DateTimeThemeData.lightEarth() => DateTimeThemeData(
        pickerBackground: _pickerBackgroundLightEarth,
        dateBackground: _dateBackgroundLightEarth,
        timeBackground: _timeBackgroundLightEarth,
        marqueeStyle: _createTextStyle(_textLight, 20),
        headerStyle: _createTextStyle(_textLight, 24),
        spinerStyle: _createTextStyle(_textLight, 18),
      );

  factory DateTimeThemeData.darkEarth() => DateTimeThemeData(
        pickerBackground: _pickerBackgroundDarkEarth,
        dateBackground: _dateBackgroundDarkEarth,
        timeBackground: _timeBackgroundDarkEarth,
        marqueeStyle: _createTextStyle(_textDark, 20),
        headerStyle: _createTextStyle(_textDark, 24),
        spinerStyle: _createTextStyle(_textDark, 18),
      );

  factory DateTimeThemeData.lightIndustrial() => DateTimeThemeData(
        pickerBackground: _pickerBackgroundLightIndustrial,
        dateBackground: _dateBackgroundLightIndustrial,
        timeBackground: _timeBackgroundLightIndustrial,
        marqueeStyle: _createTextStyle(_textLight, 20),
        headerStyle: _createTextStyle(_textLight, 24),
        spinerStyle: _createTextStyle(_textLight, 18),
      );

  factory DateTimeThemeData.darkIndustrial() => DateTimeThemeData(
        pickerBackground: _pickerBackgroundDarkIndustrial,
        dateBackground: _dateBackgroundDarkIndustrial,
        timeBackground: _timeBackgroundDarkIndustrial,
        marqueeStyle: _createTextStyle(_textDark, 20),
        headerStyle: _createTextStyle(_textDark, 24),
        spinerStyle: _createTextStyle(_textDark, 18),
      );

  final Color pickerBackground;
  final Color dateBackground;
  final Color timeBackground;
  final TextStyle marqueeStyle;
  final TextStyle headerStyle;
  final TextStyle spinerStyle;

  const DateTimeThemeData({
    required this.pickerBackground,
    required this.dateBackground,
    required this.timeBackground,
    required this.marqueeStyle,
    required this.headerStyle,
    required this.spinerStyle,
  });

  @override
  ThemeExtension<DateTimeThemeData> copyWith({
    Color? pickerBackground,
    Color? dateBackground,
    Color? timeBackground,
    TextStyle? marqueeStyle,
    TextStyle? headerStyle,
    TextStyle? spinerStyle,
  }) =>
      DateTimeThemeData(
        pickerBackground: pickerBackground ?? this.pickerBackground,
        dateBackground: dateBackground ?? this.dateBackground,
        timeBackground: timeBackground ?? this.timeBackground,
        marqueeStyle: marqueeStyle ?? this.marqueeStyle,
        headerStyle: headerStyle ?? this.headerStyle,
        spinerStyle: spinerStyle ?? this.spinerStyle,
      );

  @override
  DateTimeThemeData lerp(DateTimeThemeData? other, double t) {
    if (other is! DateTimeThemeData) return this;
    return DateTimeThemeData(
      pickerBackground:
          Color.lerp(pickerBackground, other.pickerBackground, t)!,
      dateBackground: Color.lerp(dateBackground, other.dateBackground, t)!,
      timeBackground: Color.lerp(timeBackground, other.timeBackground, t)!,
      marqueeStyle: TextStyle.lerp(marqueeStyle, other.marqueeStyle, t)!,
      headerStyle: TextStyle.lerp(headerStyle, other.headerStyle, t)!,
      spinerStyle: TextStyle.lerp(spinerStyle, other.spinerStyle, t)!,
    );
  }
}
