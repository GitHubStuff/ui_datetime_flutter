// ignore_for_file: public_member_api_docs

part of 'alarm_cubit.dart';

abstract class SystemDateTime {
  DateTime get now;
  void shutDown();
}

class RealSystemDateTime implements SystemDateTime {
  @override
  DateTime get now => DateTime.now().toUtc();

  @override
  void shutDown() {}
}

class FakeSystemDateTime implements SystemDateTime {
  FakeSystemDateTime(this.dateTime) {
    _timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (_) => _addSeconds++,
    );
  }
  final DateTime dateTime;
  int _addSeconds = 0;
  Timer? _timer;

  @override
  DateTime get now => dateTime.add(Duration(seconds: _addSeconds));

  @override
  void shutDown() {
    _timer?.cancel();
  }
}
