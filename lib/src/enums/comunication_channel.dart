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

  @override
  String toString() {
    switch (this) {
      case ComunicationChannel.whatsapp:
        return "WhatsApp";
      case ComunicationChannel.email:
        return "Email";
      case ComunicationChannel.app:
        return "Notifica app";
    }
  }
}
