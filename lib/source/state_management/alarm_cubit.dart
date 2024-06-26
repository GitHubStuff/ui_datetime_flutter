import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alarm_state.dart';
part 'system_datetime_abstract.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final SystemDateTime _systemDateTime;
  Duration? _repeatInterval;
  DateTime? _alarmDateTime;
  Timer? _timer;

//Constructor
  AlarmCubit(SystemDateTime systemDateTime)
      : _systemDateTime = systemDateTime,
        super(AlarmInitial(systemDateTime.now));

  @override
  Future<void> close() {
    _systemDateTime.shutDown();
    _timer?.cancel();
    return super.close();
  }

  void setAlarm({required DateTime toDateTime, Duration? repeating}) {
    _alarmDateTime = toDateTime.toUtc();
    _repeatInterval = repeating;
    emit(AlarmSet(_alarmDateTime!));
  }

  void turnOnAlarm() {
    if (_alarmDateTime == null) return;
    final Duration initialDelay =
        _alarmDateTime!.difference(_systemDateTime.now);
    if (!initialDelay.isNegative) {
      _timer = Timer(initialDelay, () => alarmTriggered());
    } else {
      alarmTriggered();
    }
  }

  void alarmTriggered() {
    emit(AlarmTriggered(_systemDateTime.now));
    _timer?.cancel();
    if (_repeatInterval != null) {
      _timer = Timer.periodic(
          _repeatInterval!, (_) => emit(AlarmRepeated(_systemDateTime.now)));
    }
  }

  void turnOffAlarm() {
    _timer?.cancel();
    _repeatInterval = _alarmDateTime = null;
    emit(AlarmOff(_systemDateTime.now));
  }
}
