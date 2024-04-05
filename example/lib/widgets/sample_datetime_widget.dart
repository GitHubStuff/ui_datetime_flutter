import 'package:flutter/material.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

class SampleDateTimeWidget extends StatefulWidget {
  const SampleDateTimeWidget({super.key});

  @override
  State<SampleDateTimeWidget> createState() => _SampleDateTimeWidget();
}

class _SampleDateTimeWidget extends State<SampleDateTimeWidget> {
  final globalKey = GlobalKey();
  final gKey = GlobalKey();
  String content = 'Enter Event Date and Time';
  Widget prompt =
      const Text('Event Date and Time', style: TextStyle(fontSize: 21));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIDateTimePrompt(
          key: gKey,
          initialDateTime: DateTime.now(),
          onSelected: (dateTime) {
            setState(() {
              final str = dateTime?.toIso8601String() ?? 'No Date Selected';
              prompt = Text(str, style: const TextStyle(fontSize: 21));
            });
          },
          promptWidget: prompt,
        ),
        TextButton(
          key: globalKey,
          onPressed: () async {
            final dateTime = await Navigator.of(context).push(
              dateTimeOverlayRoute<DateTime?>(
                globalKey: globalKey,
                dateTime: DateTime.now(),
                offset: const Offset(0, -180),
              ),
            );
            if (dateTime != null) {
              setState(() => content = dateTime.toIso8601String());
            }
          },
          child: Text(content),
        ),
      ],
    );
  }
}
