enum AutomationTrigger {
  subscriptionExpiration,
  medicalCertificateExpiration,
  newUser,
  birthday;

  static AutomationTrigger fromString(String value) {
    return AutomationTrigger.values.firstWhere(
      (e) => e.name == value,
      orElse: () =>
          throw ArgumentError('AutomationTrigger sconosciuto: $value'),
    );
  }

  /// newUser non ha un "prima": l'utente non esiste ancora.
  bool get allowsBefore => this != AutomationTrigger.newUser;

  String toPrettyString() {
    switch (this) {
      case AutomationTrigger.subscriptionExpiration:
        return "Scadenza abbonamento";
      case AutomationTrigger.medicalCertificateExpiration:
        return "Scadenza certificato medico";
      case AutomationTrigger.newUser:
        return "Nuovo utente";
      case AutomationTrigger.birthday:
        return "Compleanno";
    }
  }
}
