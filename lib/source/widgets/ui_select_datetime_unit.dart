import 'package:flutter/material.dart';

import '../enums/datetime_unit.dart';

/// A widget for selecting DateTimeUnit.
///
/// This widget allows users to select a DateTimeUnit, such as year, month, day, hour, minute, second,
/// millisecond, or microsecond. It provides radio buttons for each DateTimeUnit option.
///
/// The [initialUnit] parameter specifies the initial DateTimeUnit selected when the widget is first built.
///
/// The [onChanged] parameter is a callback function that is called whenever the selected DateTimeUnit changes.
///
/// The [showMillisecond] parameter determines whether to display the millisecond option.
///
/// The [showMicroSecond] parameter determines whether to display the microsecond option.
///
/// Example:
/// ```dart
/// UISelectDateTimeUnit(
///   initialUnit: DateTimeUnit.year,
///   onChanged: (unit) {
///     print('Selected DateTimeUnit: $unit');
///   },
///   showMillsecond: true,
///   showMicroSecond: false,
/// )
/// ```
class UISelectDateTimeUnit extends StatefulWidget {
  /// The initial DateTimeUnit selected when the widget is first built.
  final DateTimeUnit initialUnit;

  /// A callback function called whenever the selected DateTimeUnit changes.
  final Function(DateTimeUnit) onChanged;

  /// Determines whether to display the millisecond option.
  final bool showMillsecond;

  /// Determines whether to display the microsecond option.
  final bool showMicroSecond;

  const UISelectDateTimeUnit({
    super.key,
    required this.initialUnit,
    required this.onChanged,
    this.showMillsecond = false,
    this.showMicroSecond = false,
  });

  @override
  State<UISelectDateTimeUnit> createState() => _UISelectDateTimeUnit();
}

class _UISelectDateTimeUnit extends State<UISelectDateTimeUnit> {
  late DateTimeUnit selectedValue;
  late bool showMillisecond;
  late bool showMicroSecond;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialUnit;
    showMicroSecond = widget.showMicroSecond;
    showMillisecond = showMicroSecond || widget.showMillsecond;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              radioButton(DateTimeUnit.year),
              radioButton(DateTimeUnit.month),
              radioButton(DateTimeUnit.day),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              radioButton(DateTimeUnit.hour),
              radioButton(DateTimeUnit.minute),
              radioButton(DateTimeUnit.second),
            ],
          ),
          if (showMicroSecond || showMillisecond)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (showMillisecond) radioButton(DateTimeUnit.msec),
                if (showMicroSecond) radioButton(DateTimeUnit.usec),
                Expanded(child: Container()),
              ],
            ),
        ],
      ),
    );
  }

  /// Builds a radio button for the given [value] of DateTimeUnit.
  Widget radioButton(DateTimeUnit value) {
    return Flexible(
      child: InkWell(
        onTap: () => setSelectedValue(value),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Radio<String>(
              value: value.label,
              groupValue: selectedValue.label,
              onChanged: (value) =>
                  setSelectedValue(CapitalizeDateTimeUnit.from(value!)),
            ),
            Flexible(
              child: Text(
                value.label,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sets the selected DateTimeUnit and invokes the onChanged callback.
  void setSelectedValue(DateTimeUnit value) {
    setState(() {
      selectedValue = value;
      widget.onChanged(value);
    });
  }
}

/// Extension to capitalize the first letter of DateTimeUnit name.
extension CapitalizeDateTimeUnit on DateTimeUnit {
  /// Returns the name of DateTimeUnit with the first letter capitalized.
  String get label => name[0].toUpperCase() + name.substring(1);

  /// Converts a string to DateTimeUnit.
  static DateTimeUnit from(String string) {
    for (DateTimeUnit unit in DateTimeUnit.values) {
      if (unit.name.toLowerCase() == string.toLowerCase()) return unit;
    }
    throw ArgumentError('Invalid DateTimeUnit $string');
  }
}
