// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';

// ignore: always_use_package_imports
import 'picker_pageroute.dart';

/// A widget that displays a prompt to select a date and time.
class UIDateTimePrompt extends StatefulWidget {
  UIDateTimePrompt({
    required this.onSelected,
    required this.promptWidget,
    super.key,
    DateTime? initialDateTime,
    this.offset = const Offset(5, 30),
    this.onDoubleTap,
  }) {
    this.initialDateTime = initialDateTime ?? DateTime.now();
  }
  late final DateTime? initialDateTime;
  final void Function()? onDoubleTap;
  final void Function(DateTime?) onSelected;
  final Offset offset;
  final Widget promptWidget;

  @override
  State<UIDateTimePrompt> createState() => _UIDateTimePrompt();
}

class _UIDateTimePrompt extends State<UIDateTimePrompt> {
  final globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: widget.onDoubleTap,
      onTap: () async {
        final result = await Navigator.of(context).push<DateTime?>(
          dateTimeOverlayRoute(
            globalKey: globalKey,
            dateTime: widget.initialDateTime,
            offset: widget.offset,
          ),
        );
        widget.onSelected(result);
      },
      child: SizedBox(
        key: globalKey,
        width: double.infinity,
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.promptWidget,
          ],
        ),
      ).withSymmetricPadding(horizontal: 8),
    );
  }
}
