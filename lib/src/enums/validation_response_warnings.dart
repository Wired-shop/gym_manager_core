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

  static ValidationResponseWarnings fromString(String? value) {
    for (int i = 0; i < ValidationResponseWarnings.values.length; i++) {
      if (ValidationResponseWarnings.values[i].name == value) {
        return ValidationResponseWarnings.values[i];
      }
    }
    return ValidationResponseWarnings.sconosciuto;
  }
}
