part of 'repeating_alarm_cubit.dart';

/// Base class for all states in the repeating alarm lifecycle.
@immutable
sealed class RepeatingAlarmState {
  const RepeatingAlarmState();
}

/// Initial state of the repeating alarm, before any actions are taken.
final class RepeatingAlarmInitial extends RepeatingAlarmState {
  const RepeatingAlarmInitial();
}

/// State representing that the alarm has been manually stopped.
final class RepeatingAlarmStopped extends RepeatingAlarmState {
  const RepeatingAlarmStopped();
}

/// State representing that the alarm has been triggered.
final class RepeatingAlarmTriggered extends RepeatingAlarmState {
  const RepeatingAlarmTriggered();
}
