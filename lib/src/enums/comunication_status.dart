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
}
