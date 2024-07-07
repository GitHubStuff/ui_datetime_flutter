// ignore_for_file: avoid_redundant_argument_values, omit_local_variable_types, prefer_final_locals, require_trailing_commas

import 'package:flutter_test/flutter_test.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

void main() {
  group('DateTimeOrdering Tests', () {
    test('startEvent before endEvent', () {
      DateTime startEvent = DateTime(2024, 4, 1);
      DateTime endEvent = DateTime(2024, 4, 2);
      expect(DateTimeOrdering.direction(startEvent, endEvent),
          equals(DateTimeOrdering.before));
    });

    test('startEvent after endEvent', () {
      DateTime startEvent = DateTime(2024, 4, 3);
      DateTime endEvent = DateTime(2024, 4, 2);
      expect(DateTimeOrdering.direction(startEvent, endEvent),
          equals(DateTimeOrdering.after));
    });

    test('startEvent same as endEvent', () {
      DateTime startEvent = DateTime(2024, 4, 2);
      DateTime endEvent = DateTime(2024, 4, 2);
      expect(DateTimeOrdering.direction(startEvent, endEvent),
          equals(DateTimeOrdering.now));
    });
  });
}
