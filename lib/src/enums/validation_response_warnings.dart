enum ValidationResponseWarnings {
  iscrizioneScaduta,
  affiliazioneScaduta,
  certificatoMedicoScaduto,
  iscrizioneAssente,
  affiliazioneAssente,
  certificatoMedicoAssente,
  abbonamentoAssente,
  abbonamentoScaduto,
  accessiTerminati,
  bloccato,
  abbonamentoInScadenza,
  iscrizioneInscadenza,
  affiliazioneInScadenza,
  certificatoMedicoInScadenza,
  sconosciuto;

  static String toPrettyString(
      ValidationResponseWarnings validationResponseWarnings) {
    switch (validationResponseWarnings) {
      case ValidationResponseWarnings.sconosciuto:
        return "Sconosciuto";
      case ValidationResponseWarnings.iscrizioneScaduta:
        return "Iscrizione scaduta";
      case ValidationResponseWarnings.affiliazioneScaduta:
        return "Affiliazione scaduta";
      case ValidationResponseWarnings.certificatoMedicoScaduto:
        return "Certificato medico scaduto";
      case ValidationResponseWarnings.iscrizioneAssente:
        return "Iscrizione assente";
      case ValidationResponseWarnings.affiliazioneAssente:
        return "Affiliazione assente";
      case ValidationResponseWarnings.certificatoMedicoAssente:
        return "Certificato medico assente";
      case ValidationResponseWarnings.abbonamentoAssente:
        return "Abbonamento assente";
      case ValidationResponseWarnings.abbonamentoScaduto:
        return "Abbonamento scaduto";
      case ValidationResponseWarnings.accessiTerminati:
        return "Accessi terminati";
      case ValidationResponseWarnings.bloccato:
        return "Bloccato";
      case ValidationResponseWarnings.abbonamentoInScadenza:
        return "Abbonamento in scadenza";
      case ValidationResponseWarnings.iscrizioneInscadenza:
        return "Iscrizione in scadenza";
      case ValidationResponseWarnings.affiliazioneInScadenza:
        return "Affiliazione in scadenza";
      case ValidationResponseWarnings.certificatoMedicoInScadenza:
        return "Certificato medico in scadenza";
    }
  }
}
