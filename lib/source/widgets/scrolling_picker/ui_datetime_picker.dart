import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_aqua_button_flutter/ui_aqua_button_flutter.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';
import 'package:ui_marquee_flutter/ui_marguee_flutter.dart';

import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

import 'ui_date_picker_wheel.dart';
import 'ui_timer_picker_wheel.dart';

part 'datetime_caption.dart';

const Size kDateTimePickerSize = Size(230, 250);

const double _kItemExtent = 30.0;
const Duration _kCrossFadeDuration = Duration(milliseconds: 500);
const Widget _kDateButtonText = DateTimeCaption(caption: 'Date');
const Widget _kTimeButtonText = DateTimeCaption(caption: 'Time');

// Enum for Opacity values
enum OpacityEnum {
  show(1.0),
  hide(0.0);

  final double value;

  const OpacityEnum(this.value);
}

// Define a method to create MaterialColor
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

// Define myBlue using the darkest shade as the main color
final MaterialColor myBlue = createMaterialColor(const Color(0xFF003366));

/// A Flutter widget for selecting date and time.
class UIDateTimePicker extends StatefulWidget {
  // Constructor for UICalendarFlutter
  UIDateTimePicker({
    super.key,
    required this.onDateTimeSelected,
    DateTime? dateTime,
    DateFormat? dateFormat,
    this.dateText = _kDateButtonText,
    this.acceptButton = const AquaButton(
      radius: 22.0,
      materialColor: Colors.blue,
    ),
    this.showFirstWidget = true,
    this.size = kDateTimePickerSize,
    this.timeText = _kTimeButtonText,
  })  : dateTime = dateTime ?? DateTime.now(),
        dateFormat = dateFormat ?? DateFormat(DT.kDateTimeFormat);

  // Properties of the UICalendarFlutter widget
  final DateTime dateTime;
  final Function(DateTime) onDateTimeSelected;
  final bool showFirstWidget;
  final DateFormat dateFormat;
  final Size size;
  final Widget dateText;
  final Widget acceptButton;
  final Widget timeText;

  @override
  State<UIDateTimePicker> createState() => _UIDateTimePicker();
}

/// State class for UICalendarFlutter widget.
class _UIDateTimePicker extends State<UIDateTimePicker> {
  late DateTime dateTime;
  late bool showFirstWidget;

  @override
  void initState() {
    super.initState();
    // Initialize dateTime and showFirstWidget variables
    dateTime = widget.dateTime.copyWith(
      year: widget.dateTime.year,
      month: widget.dateTime.month,
      day: widget.dateTime.day,
      hour: widget.dateTime.hour,
      minute: widget.dateTime.minute,
      second: widget.dateTime.second,
      millisecond: 0,
      microsecond: 0,
    );
    showFirstWidget = widget.showFirstWidget;
  }

  @override
  Widget build(BuildContext context) {
    DateTimePickerTheme pickerTheme = DateTimePickerTheme.of(context);
    return Container(
      // Prevents the height from being zero which throws sizing error
      height: max(widget.size.height, 0.00000000001),
      width: widget.size.width,
      color: Colors.transparent,
      child: _column(pickerTheme), //pickers(context),
    );
  }

  Widget _column(DateTimePickerTheme pickerTheme) {
    return Column(
      children: [
        Flexible(flex: 4, child: _buildTitle(pickerTheme)),
        Flexible(flex: 4, child: _buildDateTimeSelectionButtons(pickerTheme)),
        Expanded(flex: 8, child: _buildPickerWheels(pickerTheme)),
      ],
    );
  }

  Widget _buildTitle(DateTimePickerTheme pickerTheme) {
    return Container(
      color: pickerTheme.pickerBackground,
      height: 44.0,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: UIMarqueeWidget(
              message: widget.dateFormat.format(dateTime),
              rolloverPercentage: 0.85,
              pauseDuration: const Duration(milliseconds: 10),
              scrollVelocityInPixelsPerSecond: 30.0,
              textStyle: pickerTheme.marqueeStyle,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () => widget.onDateTimeSelected(DT.makeUtc(dateTime)),
              child: widget.acceptButton,
            ).withPadding(left: 2.0, top: 4.0, bottom: 4.0),
          ),
        ],
      ).withPaddingAll(3.0),
    );
  }

  Widget _buildDateTimeSelectionButtons(DateTimePickerTheme pickerTheme) {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showFirstWidget = true),
              child: Container(
                color: pickerTheme.dateBackground,
                child: Center(child: widget.dateText),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showFirstWidget = false),
              child: Container(
                color: pickerTheme.timeBackground,
                child: Center(child: widget.timeText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerWheels(DateTimePickerTheme pickerTheme) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: !showFirstWidget,
          child: AnimatedOpacity(
            opacity: showFirstWidget
                ? OpacityEnum.show.value
                : OpacityEnum.hide.value,
            duration: _kCrossFadeDuration,
            child: UIDatePickerWheel(
              dateTime: dateTime,
              backgroundColor: pickerTheme.dateBackground,
              pickerItemExtent: _kItemExtent,
              textStyle: pickerTheme.spinerStyle,
              onDateSelected: (DateTime newDateTime) {
                setState(
                  () => dateTime = dateTime.copyWith(
                    year: newDateTime.year,
                    month: newDateTime.month,
                    day: newDateTime.day,
                    hour: dateTime.hour,
                    minute: dateTime.minute,
                    second: dateTime.second,
                  ),
                );
              },
            ),
          ),
        ),
        IgnorePointer(
          ignoring: showFirstWidget,
          child: AnimatedOpacity(
            opacity: showFirstWidget
                ? OpacityEnum.hide.value
                : OpacityEnum.show.value,
            duration: _kCrossFadeDuration,
            child: UITimePickerWheel(
              dateTime: dateTime,
              backgroundColor: pickerTheme.timeBackground,
              textStyle: pickerTheme.spinerStyle,
              onTimeSelected: (DateTime newDateTime) {
                setState(
                  () => dateTime = dateTime.copyWith(
                    year: dateTime.year,
                    month: dateTime.month,
                    day: dateTime.day,
                    hour: newDateTime.hour,
                    minute: newDateTime.minute,
                    second: newDateTime.second,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
