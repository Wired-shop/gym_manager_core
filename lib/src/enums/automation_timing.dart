enum AutomationTiming {
  before,
  sameDay,
  after;

  static AutomationTiming fromString(String value) {
    return AutomationTiming.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('AutomationTiming sconosciuto: $value'),
    );
  }

  String toPrettyString() {
    switch (this) {
      case AutomationTiming.before:
        return "Prima";
      case AutomationTiming.sameDay:
        return "Il giorno stesso";
      case AutomationTiming.after:
        return "Dopo";
    }
  }
}
