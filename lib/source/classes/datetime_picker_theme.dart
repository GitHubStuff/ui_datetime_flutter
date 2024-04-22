import 'package:flutter/material.dart';

const Color _textLight = _textDark;
const Color _textDark = Color(0xffFFEB3B);
TextStyle _textStyle(Color color, double fontSize) => TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

class DateTimePickerTheme extends ThemeExtension<DateTimePickerTheme> {
  factory DateTimePickerTheme.light() => DateTimePickerTheme(
        pickerBackground: Colors.white,
        dateBackground: Colors.white,
        timeBackground: Colors.white,
        marqueeStyle: _textStyle(_textLight, 20),
        headerStyle: _textStyle(_textLight, 24),
        spinerStyle: _textStyle(_textLight, 18),
      );
  factory DateTimePickerTheme.dark() => DateTimePickerTheme(
        pickerBackground: Colors.black87,
        dateBackground: Colors.indigo[900]!,
        timeBackground: Colors.blue[900]!,
        marqueeStyle: _textStyle(_textLight, 20),
        headerStyle: _textStyle(_textLight, 24),
        spinerStyle: _textStyle(_textLight, 18),
      );

  final Color pickerBackground;
  final Color dateBackground;
  final Color timeBackground;
  final TextStyle marqueeStyle;
  final TextStyle headerStyle;
  final TextStyle spinerStyle;

  const DateTimePickerTheme({
    required this.pickerBackground,
    required this.dateBackground,
    required this.timeBackground,
    required this.marqueeStyle,
    required this.headerStyle,
    required this.spinerStyle,
  });

  @override
  DateTimePickerTheme copyWith({
    Color? pickerBackground,
    Color? dateBackground,
    Color? timeBackground,
    TextStyle? marqueeStyle,
    TextStyle? headerStyle,
    TextStyle? spinerStyle,
  }) =>
      DateTimePickerTheme(
        pickerBackground: pickerBackground ?? this.pickerBackground,
        dateBackground: dateBackground ?? this.dateBackground,
        timeBackground: timeBackground ?? this.timeBackground,
        marqueeStyle: marqueeStyle ?? this.marqueeStyle,
        headerStyle: headerStyle ?? this.headerStyle,
        spinerStyle: spinerStyle ?? this.spinerStyle,
      );

  @override
  DateTimePickerTheme lerp(
      ThemeExtension<DateTimePickerTheme>? other, double t) {
    if (other == null) return this;
    if (other is DateTimePickerTheme) {
      return DateTimePickerTheme(
        pickerBackground:
            Color.lerp(pickerBackground, other.pickerBackground, t)!,
        dateBackground: Color.lerp(dateBackground, other.dateBackground, t)!,
        timeBackground: Color.lerp(timeBackground, other.timeBackground, t)!,
        marqueeStyle: TextStyle.lerp(marqueeStyle, other.marqueeStyle, t)!,
        headerStyle: TextStyle.lerp(headerStyle, other.headerStyle, t)!,
        spinerStyle: TextStyle.lerp(spinerStyle, other.spinerStyle, t)!,
      );
    }
    return this;
  }
}
