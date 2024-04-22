import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'repeating_alarm_state.dart';

/// A Cubit that manages the state of a repeating alarm.
///
/// The alarm can be configured to trigger at a specific time and optionally
/// repeat at a specified interval.
class RepeatingAlarmCubit extends Cubit<RepeatingAlarmState> {
  Timer? _timer;

  /// The DateTime when the alarm should first go off.
  final DateTime alarmDateTime;

  /// The interval at which the alarm should repeat.
  ///
  /// If null, the alarm will not repeat after it has been triggered once.
  final Duration? repeatInterval;

  /// Creates an instance of a repeating alarm.
  ///
  /// Requires an initial alarm time. Optionally, a repeat interval can be provided.
  RepeatingAlarmCubit({required this.alarmDateTime, this.repeatInterval})
      : super(const RepeatingAlarmInitial());

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  /// Starts the alarm.
  ///
  /// If the current time is past the initial alarm time, triggers the alarm immediately
  /// and sets it to repeat at the specified interval.
  void startAlarm() {
    DateTime now = DateTime.now().toUtc();
    DateTime alarmTime = alarmDateTime.toUtc();
    final Duration initialDelay = alarmTime.difference(now);
    if (initialDelay.isNegative) {
      emit(const RepeatingAlarmTriggered());
      _repeatAlarm();
    } else {
      _timer = Timer(initialDelay, () {
        emit(const RepeatingAlarmTriggered());
        _repeatAlarm();
      });
    }
  }

  /// Stops the alarm.
  ///
  /// Cancels any ongoing timers and emits a `RepeatingAlarmStopped` state.
  void stopAlarm() {
    _timer?.cancel();
    emit(const RepeatingAlarmStopped());
  }

  /// Helper method to set up a repeating alarm using the interval specified.
  ///
  /// If a repeat interval is set, it configures a periodic timer that triggers the alarm.
  void _repeatAlarm() {
    _timer?.cancel();
    if (repeatInterval != null) {
      _timer = Timer.periodic(repeatInterval!, (timer) {
        emit(const RepeatingAlarmTriggered());
      });
    }
  }
}
