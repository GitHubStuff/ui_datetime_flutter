// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

import '../widgets/sample_datetime_widget.dart';

AlarmCubit _rac = AlarmCubit(FakeSystemDateTime(DateTime(2024, 1, 15, 14, 30)));

/// The group number for the RadioButtonCubit
int group = 2;

///
class HomeScaffold extends StatelessWidget {
  /// Constructor for HomeScaffold.
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
    );
  }

  /// The main widget for the home screen.
  Widget homeWidget(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTimeDifference(
                startEvent: DateTime(1960, 12, 19, 15, 56),
                endEvent: DateTime.now(),
              ).toString(),
            ),
            const Gap(5),
            const RepeatingAlarmWidget(),
            const Gap(1),
            const Text('Date Time Picker: Propmt and Overlay'),
            const SampleDateTimeWidget(),
            const Gap(3),
            ElevatedButton(
              onPressed: () {
                _rac
                  ..setAlarm(
                    toDateTime: DateTime.now().add(const Duration(seconds: 10)),
                  )
                  ..turnOnAlarm();
              },
              child: const Text('Start Repeating Alarm'),
            ),
            ElevatedButton(
              onPressed: () => _rac.turnOffAlarm(),
              child: const Text('Stop Repeating Alarm'),
            ),
            const Gap(3),
            const Text('-----------------------------------'),
            ElevatedButton(
              onPressed: () {
                DateTimeToast.show(
                  message: 'Toast Example',
                  dateTime: DateTime(2024, 1, 15, 14, 30),
                  duration: const Duration(seconds: 3),
                );
              },
              child: const Text('Show datetime Toast\n(Toast with DateTime)'),
            ),
            const Text('-----------------------------------'),
            const Gap(3),
            const Text('Time Unit Radio Button Selector:'),
            UISelectDateTimeUnit(
              initialUnit: DateTimeUnit.month,
              showMicroSecond: true,
              onChanged: (unit) {
                DateTimeToast.show(
                  message: 'Selected unit: $unit',
                  duration: const Duration(seconds: 1),
                );
              },
            ),
          ],
        ),
      );
}

/// A widget that displays a repeating alarm.
class RepeatingAlarmWidget extends StatefulWidget {
  /// Constructor for RepeatingAlarmWidget.
  const RepeatingAlarmWidget({super.key});

  @override
  State<RepeatingAlarmWidget> createState() => _RepeatingAlarmWidget();
}

class _RepeatingAlarmWidget extends State<RepeatingAlarmWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmCubit, AlarmState>(
      bloc: _rac,
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'Alarm - ${DateTime.now().formatted()}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        );
      },
    );
  }
}
