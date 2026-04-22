import 'package:gym_manager_core/core.dart';

class Validator {
  static ValidationResult validate(
      {required User user,
      required Subscription? subscription,
      int inExpiringFiltersDays = 10}) {
    List<ValidationResponseWarnings> warnings = [];

    if (subscription == null) {
      warnings.add(ValidationResponseWarnings.abbonamentoAssente);
    }
    if (subscription != null) {
      // Scadenza abbonamento
      if (subscription.expiration.isBefore(DateTime.now())) {
        warnings.add(ValidationResponseWarnings.abbonamentoScaduto);
      } else if (subscription.expiration.isBefore(
          DateTime.now().add(Duration(days: inExpiringFiltersDays)))) {
        warnings.add(ValidationResponseWarnings.abbonamentoInScadenza);
      }

      // Accessi disponibili
      if (subscription.accessesAvaiable != null &&
          subscription.accessesAvaiable == 0) {
        warnings.add(ValidationResponseWarnings.accessiDisponibiliEsauriti);
      }
    }

    // Certificato medico
    if (user.medicalCertificateExpiration != null) {
      if (user.medicalCertificateExpiration!.isBefore(DateTime.now())) {
        warnings.add(ValidationResponseWarnings.certificatoMedicoScaduto);
      } else if (user.medicalCertificateExpiration!.isBefore(
          DateTime.now().add(Duration(days: inExpiringFiltersDays)))) {
        warnings.add(ValidationResponseWarnings.certificatoMedicoInScadenza);
      }
    } else {
      warnings.add(ValidationResponseWarnings.certificatoMedicoAssente);
    }

    // Affiliazione
    if (user.affiliationExpiration != null) {
      if (user.affiliationExpiration!.isBefore(DateTime.now())) {
        warnings.add(ValidationResponseWarnings.affiliazioneScaduta);
      } else if (user.affiliationExpiration!.isBefore(
          DateTime.now().add(Duration(days: inExpiringFiltersDays)))) {
        warnings.add(ValidationResponseWarnings.affiliazioneInScadenza);
      }
    } else {
      warnings.add(ValidationResponseWarnings.affiliazioneAssente);
    }

    if (user.subscriptionExpiration != null) {
      if (user.subscriptionExpiration!.isBefore(DateTime.now())) {
        warnings.add(ValidationResponseWarnings.iscrizioneScaduta);
      } else if (user.subscriptionExpiration!.isBefore(
          DateTime.now().add(Duration(days: inExpiringFiltersDays)))) {
        warnings.add(ValidationResponseWarnings.iscrizioneInScadenza);
      }
    } else {
      warnings.add(ValidationResponseWarnings.iscrizioneAssente);
    }

    return ValidationResult(
        ValidationResult.fromAssociatedWarnings(warnings), warnings);
  }
}
