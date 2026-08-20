enum ComunicationStatus {
  completed,
  active,
  scheduled;

  static ComunicationStatus fromString(String value) {
    return ComunicationStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('CampaignStatus sconosciuto: $value'),
    );
  }

  String toPrettyString() {
    switch (this) {
      case ComunicationStatus.active:
        return "Attiva";
      case ComunicationStatus.scheduled:
        return "Programmata";
      case ComunicationStatus.completed:
        return "Completata";
    }
  }
}
