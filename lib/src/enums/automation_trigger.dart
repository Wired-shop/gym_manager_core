enum AutomationTrigger {
  birthday,
  subscriptionExpiring,
  medicalCertificateExpiring,
  affiliationExpiring;

  static AutomationTrigger fromString(String value) {
    return AutomationTrigger.values.firstWhere(
      (e) => e.name == value,
      orElse: () =>
          throw ArgumentError('AutomationTrigger sconosciuto: $value'),
    );
  }

  bool get usesOffset => this != AutomationTrigger.birthday;

  String toPrettyString() {
    switch (this) {
      case AutomationTrigger.birthday:
        return "Compleanno";
      case AutomationTrigger.subscriptionExpiring:
        return "Scadenza abbonamento";
      case AutomationTrigger.medicalCertificateExpiring:
        return "Scadenza certificato medico";
      case AutomationTrigger.affiliationExpiring:
        return "Scadenza tesseramento";
    }
  }

  String eventLabel() {
    switch (this) {
      case AutomationTrigger.birthday:
        return "del compleanno";
      case AutomationTrigger.subscriptionExpiring:
        return "della scadenza dell'abbonamento";
      case AutomationTrigger.medicalCertificateExpiring:
        return "della scadenza del certificato medico";
      case AutomationTrigger.affiliationExpiring:
        return "della scadenza del tesseramento";
    }
  }
}
