import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

class MockTimer extends Mock implements Timer {}

const mockSystemDateTime = '2024-04-16T12:00:00.000Z';
const String mockAlarmDateTime = '2024-04-16T12:00:05.000Z';

void main() {
  group('RepeatingAlarmCubit', () {
    late AlarmCubit cubit;
    late FakeSystemDateTime fakeDateTime;
    final alarmDateTime = DateTime.parse(mockAlarmDateTime);
    final systemDateTime = DateTime.parse(mockSystemDateTime);

    setUp(() {
      fakeDateTime = FakeSystemDateTime(DateTime.parse(mockSystemDateTime));
      cubit = AlarmCubit(fakeDateTime);
    });

    tearDown(() {
      cubit.close();
      fakeDateTime.shutDown();
    });

    test('initial state is RepeatingAlarmInitial', () {
      expect(cubit.state, AlarmInitial(cubit.state.dateTime));
    });

    blocTest<AlarmCubit, AlarmState>(
      'emits RepeatingAlarmTriggered when startAlarm is called and time is up',
      build: () => cubit,
      act: (cubit) {
        cubit
          ..setAlarm(toDateTime: alarmDateTime)
          ..turnOnAlarm();
      },
      verify: (_) {
        expect(cubit.state.dateTime.isAfter(systemDateTime), true);
      },
    );

    blocTest<AlarmCubit, AlarmState>(
      'emits RepeatingAlarmStopped when stopAlarm is called',
      build: () => cubit,
      act: (cubit) async {
        cubit.setAlarm(toDateTime: alarmDateTime);
        // ignore: inference_failure_on_instance_creation
        await Future.delayed(const Duration(seconds: 5));
        cubit.turnOnAlarm();
      },
      verify: (cubit) {
        expect(cubit.state, isA<AlarmTriggered>());
      },
      expect: () => [AlarmSet(alarmDateTime), AlarmTriggered(fakeDateTime.now)],
    );
  });
}
