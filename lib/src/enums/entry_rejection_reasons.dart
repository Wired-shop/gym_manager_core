import '../../core.dart';

enum EntryRejectionReason {
  // Operativi
  accessiGiornalieriEsauriti,
  accessiDisponibiliEsauriti,
  fuoriFasciaOraria,
  bloccato,

  // Validazione
  iscrizioneScaduta,
  affiliazioneScaduta,
  certificatoMedicoScaduto,
  iscrizioneAssente,
  affiliazioneAssente,
  certificatoMedicoAssente,
  abbonamentoAssente,
  abbonamentoScaduto,
  accessiTerminati,
  iscrizioneInScadenza,
  abbonamentoInScadenza,
  affiliazioneInScadenza,
  certificatoMedicoInScadenza,

  sconosciuto;

  static EntryRejectionReason fromString(String? value) {
    return EntryRejectionReason.values.firstWhere(
      (e) => e.name == value,
      orElse: () => EntryRejectionReason.sconosciuto,
    );
  }

  static EntryRejectionReason fromValidationWarning(
    ValidationResponseWarnings w,
  ) {
    return fromString(w.name);
  }

  String toPrettyString() {
    switch (this) {
      case EntryRejectionReason.accessiGiornalieriEsauriti:
        return "Accessi giornalieri esauriti";
      case EntryRejectionReason.accessiDisponibiliEsauriti:
        return "Accessi disponibili esauriti";
      case EntryRejectionReason.fuoriFasciaOraria:
        return "Fuori fascia oraria";
      case EntryRejectionReason.bloccato:
        return "Bloccato";
      case EntryRejectionReason.iscrizioneScaduta:
        return "Iscrizione scaduta";
      case EntryRejectionReason.affiliazioneScaduta:
        return "Affiliazione scaduta";
      case EntryRejectionReason.certificatoMedicoScaduto:
        return "Certificato medico scaduto";
      case EntryRejectionReason.iscrizioneAssente:
        return "Iscrizione assente";
      case EntryRejectionReason.affiliazioneAssente:
        return "Affiliazione assente";
      case EntryRejectionReason.certificatoMedicoAssente:
        return "Certificato medico assente";
      case EntryRejectionReason.abbonamentoAssente:
        return "Abbonamento assente";
      case EntryRejectionReason.abbonamentoScaduto:
        return "Abbonamento scaduto";
      case EntryRejectionReason.accessiTerminati:
        return "Accessi terminati";
      case EntryRejectionReason.iscrizioneInScadenza:
        return "Iscrizione in scadenza";
      case EntryRejectionReason.abbonamentoInScadenza:
        return "Abbonamento in scadenza";
      case EntryRejectionReason.affiliazioneInScadenza:
        return "Affiliazione in scadenza";
      case EntryRejectionReason.certificatoMedicoInScadenza:
        return "Certificato medico in scadenza";
      case EntryRejectionReason.sconosciuto:
        return "Sconosciuto";
    }
  }
}
