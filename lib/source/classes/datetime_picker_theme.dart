import 'package:flutter/material.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';

const Color _textLight = Colors.white;
const Color _textDark = Color(0xffFFEB3B);
TextStyle _textStyle(Color color, double fontSize) => TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

class DateTimePickerTheme extends ThemeExtension<DateTimePickerTheme> {
  factory DateTimePickerTheme.lightEarth() => DateTimePickerTheme(
        pickerBackground: const Color(0xffe2725b),
        dateBackground: const Color(0xffFFEB3B),
        timeBackground: const Color(0xffF4DECB),
        marqueeStyle: _textStyle(_textLight, 20),
        headerStyle: _textStyle(_textLight, 24),
        spinerStyle: _textStyle(_textLight, 18),
      );

  factory DateTimePickerTheme.darkEarth() => DateTimePickerTheme(
        pickerBackground: const Color(0xffCB4F3A),
        dateBackground: const Color(0xff394D2E),
        timeBackground: const Color(0xff5A4E44),
        marqueeStyle: _textStyle(_textDark, 20),
        headerStyle: _textStyle(_textDark, 24),
        spinerStyle: _textStyle(_textDark, 18),
      );

  factory DateTimePickerTheme.lightIndustrial() => DateTimePickerTheme(
        pickerBackground: const Color(0xff2A3439),
        dateBackground: const Color(0xff333840),
        timeBackground: const Color(0xff4682B4),
        marqueeStyle: _textStyle(_textLight, 20),
        headerStyle: _textStyle(_textLight, 24),
        spinerStyle: _textStyle(_textLight, 18),
      );

  factory DateTimePickerTheme.darkIndustrial() => DateTimePickerTheme(
        pickerBackground: const Color(0xff222222),
        dateBackground: const Color(0xff191970),
        timeBackground: const Color(0xff1A1A1A),
        marqueeStyle: _textStyle(_textDark, 20),
        headerStyle: _textStyle(_textDark, 24),
        spinerStyle: _textStyle(_textDark, 18),
      );

  factory DateTimePickerTheme.getTheme(BuildContext context) {
    DateTimePickerTheme? theme = context.theme.extension<DateTimePickerTheme>();
    if (theme != null) return theme;
    return context.theme.brightness == Brightness.dark
        ? DateTimePickerTheme.darkIndustrial()
        : DateTimePickerTheme.lightIndustrial();
  }
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
