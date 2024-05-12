part of 'alarm_cubit.dart';

@immutable
sealed class AlarmState extends Equatable {
  final DateTime dateTime;
  const AlarmState(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}

final class AlarmInitial extends AlarmState {
  const AlarmInitial(super.dateTime);
}

final class AlarmSet extends AlarmState {
  const AlarmSet(super.dateTime);
}

final class AlarmTriggered extends AlarmState {
  const AlarmTriggered(super.dateTime);
}

final class AlarmRepeated extends AlarmState {
  const AlarmRepeated(super.dateTime);
}

final class AlarmOff extends AlarmState {
  const AlarmOff(super.dateTime);
}
