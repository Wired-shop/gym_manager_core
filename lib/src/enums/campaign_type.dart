enum CampaignType {
  whatsapp,
  email,
  app;

  static CampaignType fromString(String value) {
    return CampaignType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('CampaignType sconosciuto: $value'),
    );
  }
}
