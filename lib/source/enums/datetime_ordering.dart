/// Enum for representing the relation between two DateTime values
library;
// ignore_for_file: public_member_api_docs

enum DateTimeOrdering {
  before,
  now,
  after;

  /// Returns the relation between startEvent and endEvent
  /// If startEvent is before endEvent, it returns DateTimeRelation.before
  /// If startEvent is after endEvent, it returns DateTimeRelation.after
  /// If startEvent is the same as endEvent, it returns DateTimeRelation.now
  static DateTimeOrdering direction(DateTime startEvent, DateTime endEvent) {
    if (startEvent.isBefore(endEvent)) return DateTimeOrdering.before;
    if (startEvent.isAfter(endEvent)) return DateTimeOrdering.after;
    return DateTimeOrdering.now;
  }
}
