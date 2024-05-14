import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_aqua_button_flutter/ui_aqua_button_flutter.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';
import 'package:ui_marquee_flutter/ui_marquee_flutter.dart';

import 'ui_date_picker_wheel.dart';
import 'ui_time_picker_wheel.dart';

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

// Define myBlue using the darkest shade as the main color
final MaterialColor myBlue = createMaterialColor(const Color(0xFF003366));

/// A Flutter widget for selecting date and time.
class UIDateTimePicker extends StatefulWidget {
  // Constructor for UIDateTimePicker
  UIDateTimePicker({
    super.key,
    required this.onDateTimeSelected,
    DateTime? dateTime,
    DateFormat? dateFormat,
    this.dateText = _kDateButtonText,
    this.acceptButton =
        const AquaButton(radius: 22.0, materialColor: Colors.blue),
    this.showFirstWidget = true,
    this.size = kDateTimePickerSize,
    this.timeText = _kTimeButtonText,
  })  : dateTime = dateTime ?? DateTime.now(),
        dateFormat = dateFormat ?? DateFormat(DT.kDateTimeFormat);

  final DateTime dateTime;
  final Function(DateTime) onDateTimeSelected;
  final bool showFirstWidget;
  final DateFormat dateFormat;
  final Size size;
  final Widget dateText;
  final Widget acceptButton;
  final Widget timeText;

  @override
  State<UIDateTimePicker> createState() => _UIDateTimePickerState();
}

class _UIDateTimePickerState extends State<UIDateTimePicker> {
  late DateTime dateTime;
  late bool showFirstWidget;

  @override
  void initState() {
    super.initState();
    dateTime = widget.dateTime.copyWith(
      millisecond: 0,
      microsecond: 0,
    );
    showFirstWidget = widget.showFirstWidget;
  }

  @override
  Widget build(BuildContext context) {
    DateTimeThemeData pickerData = DateTimePickerTheme.of(context);
    return Container(
      height: max(widget.size.height, 0.00000000001),
      width: widget.size.width,
      color: Colors.transparent,
      child: _buildColumn(pickerData),
    );
  }

  Widget _buildColumn(DateTimeThemeData pickerTheme) {
    return Column(
      children: [
        Flexible(flex: 4, child: _buildTitle(pickerTheme)),
        Flexible(flex: 4, child: _buildDateTimeSelectionButtons(pickerTheme)),
        Expanded(flex: 8, child: _buildPickerWheels(pickerTheme)),
      ],
    );
  }

  Widget _buildTitle(DateTimeThemeData pickerTheme) {
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

  Widget _buildDateTimeSelectionButtons(DateTimeThemeData pickerTheme) {
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

  Widget _buildPickerWheels(DateTimeThemeData pickerTheme) {
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
                setState(() {
                  dateTime = dateTime.copyWith(
                    year: newDateTime.year,
                    month: newDateTime.month,
                    day: newDateTime.day,
                  );
                });
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
                setState(() {
                  dateTime = dateTime.copyWith(
                    hour: newDateTime.hour,
                    minute: newDateTime.minute,
                    second: newDateTime.second,
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
