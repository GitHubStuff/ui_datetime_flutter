// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../enums/datetime_unit.dart';

/// A widget for selecting a DateTimeUnit.
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
  const UISelectDateTimeUnit({
    required this.initialUnit,
    required this.onChanged,
    super.key,
    this.showMillisecond = false,
    this.showMicroSecond = false,
  });
  final DateTimeUnit initialUnit;
  final ValueChanged<DateTimeUnit> onChanged;
  final bool showMillisecond;
  final bool showMicroSecond;

  @override
  State<UISelectDateTimeUnit> createState() => _UISelectDateTimeUnitState();
}

class _UISelectDateTimeUnitState extends State<UISelectDateTimeUnit> {
  late DateTimeUnit selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialUnit;
  }

  @override
  Widget build(BuildContext context) {
    final showMillisecond = widget.showMillisecond || widget.showMicroSecond;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildRow([DateTimeUnit.year, DateTimeUnit.month, DateTimeUnit.day]),
          _buildRow(
            [DateTimeUnit.hour, DateTimeUnit.minute, DateTimeUnit.second],
          ),
          if (showMillisecond)
            _buildRow(
              [
                if (showMillisecond) DateTimeUnit.msec,
                if (widget.showMicroSecond) DateTimeUnit.usec,
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRow(List<DateTimeUnit> units) {
    final result = Row(
      // ignore: avoid_redundant_argument_values
      mainAxisAlignment: MainAxisAlignment.start,
      children: units.map(_buildRadioButton).toList(),
    );

    return result;
  }

  Widget _buildRadioButton(DateTimeUnit value) {
    return Flexible(
      child: InkWell(
        onTap: () => _setSelectedValue(value),
        child: Row(
          // ignore: avoid_redundant_argument_values
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Radio<String>(
              value: value.label,
              groupValue: selectedValue.label,
              onChanged: (_) => _setSelectedValue(value),
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

  void _setSelectedValue(DateTimeUnit value) {
    setState(() {
      selectedValue = value;
      widget.onChanged(value);
    });
  }
}

extension CapitalizeDateTimeUnit on DateTimeUnit {
  String get label => name[0].toUpperCase() + name.substring(1);

  static DateTimeUnit from(String string) {
    return DateTimeUnit.values.firstWhere(
      (unit) => unit.name.toLowerCase() == string.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid DateTimeUnit $string'),
    );
  }
}
