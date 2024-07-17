enum EntryResponseWarnings {
  iscrizioneScaduta,
  affiliazioneScaduta,
  certificatoMedicoScaduto,
  abbonamentoScaduto,
  accessiTerminati,
  sconosciuto;

  static EntryResponseWarnings fromValue(String? value) {
    for (int i = 0; i < EntryResponseWarnings.values.length; i++) {
      if (EntryResponseWarnings.values[i].name == value) {
        return EntryResponseWarnings.values[i];
      }
    }
    return EntryResponseWarnings.sconosciuto;
  }
}
