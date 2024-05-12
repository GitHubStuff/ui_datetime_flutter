// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../gen/assets.gen.dart';

import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

import '../widgets/sample_datetime_widget.dart';

int group = 2;

///
class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.clockcalendar.image(),
            ),
          ),
          const Gap(5),
          ElevatedButton(
            onPressed: () {
              DateTimeToast().show(
                message: "Toast Example",
                dateTime: DateTime(2024, 1, 15, 14, 30),
                duration: const Duration(seconds: 3),
                position: DateTimeToastPosition.bottom,
              );
            },
            child: const Text('Show datetime Toast'),
          ),
          const Gap(5),
          UISelectDateTimeUnit(
            initialUnit: DateTimeUnit.month,
            onChanged: (unit) {
              DateTimeToast().show(
                message: 'Selected unit: $unit',
                dateTime: DateTime(2024, 1, 15, 14, 30),
                duration: const Duration(seconds: 1),
                position: DateTimeToastPosition.bottom,
              );
            },
          ),
          const Gap(5),
          UIDateTimePicker(
              onDateTimeSelected: (dateTime) => DateTimeToast().show(
                    message: 'Selected unit: ${dateTime.formatted()}',
                    dateTime: DateTime(2024, 1, 15, 14, 30),
                    duration: const Duration(seconds: 4),
                    position: DateTimeToastPosition.bottom,
                  )),
          const SizedBox(height: 10),
          const SampleDateTimeWidget(),
        ],
      ),
    );
  }
}
