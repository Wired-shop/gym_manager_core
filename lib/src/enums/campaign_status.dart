enum CampaignStatus {
  completed,
  active,
  scheduled;

  static CampaignStatus fromString(String value) {
    return CampaignStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('CampaignStatus sconosciuto: $value'),
    );
  }
}
