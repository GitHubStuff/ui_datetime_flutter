import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

class MockTimer extends Mock implements Timer {}

void main() {
  group('RepeatingAlarmCubit', () {
    late RepeatingAlarmCubit cubit;
    late MockTimer mockTimer;
    late DateTime fixedCurrentTime;

    setUp(() {
      mockTimer = MockTimer();
      fixedCurrentTime = DateTime.parse("2024-04-16T12:00:00Z");
      when(() => mockTimer.cancel()).thenReturn(null);

      // Mocking DateTime.now to control time in tests
      cubit = RepeatingAlarmCubit(
        alarmDateTime: fixedCurrentTime.add(const Duration(minutes: 5)),
        repeatInterval: const Duration(minutes: 5),
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is RepeatingAlarmInitial', () {
      expect(cubit.state, const RepeatingAlarmInitial());
    });

    blocTest<RepeatingAlarmCubit, RepeatingAlarmState>(
      'emits RepeatingAlarmTriggered when startAlarm is called and time is up',
      build: () => cubit,
      act: (cubit) => cubit.startAlarm(),
      expect: () => const [RepeatingAlarmTriggered()],
    );

    blocTest<RepeatingAlarmCubit, RepeatingAlarmState>(
      'emits RepeatingAlarmStopped when stopAlarm is called',
      build: () => cubit,
      act: (cubit) {
        cubit.startAlarm();
        cubit.stopAlarm();
      },
      expect: () => const [RepeatingAlarmTriggered(), RepeatingAlarmStopped()],
    );
  });
}
