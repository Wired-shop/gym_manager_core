enum ComunicationChannel {
  whatsapp,
  email,
  app;

  static ComunicationChannel fromString(String value) {
    return ComunicationChannel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('CampaignType sconosciuto: $value'),
    );
  }
}
