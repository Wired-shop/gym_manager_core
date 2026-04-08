enum EntryRejectionReasons {
  accessiGiornalieriEsauriti,
  accessiDisponibiliEsauriti,
  fuoriFasciaOraria,
  sconosciuto;

  static EntryRejectionReasons fromString(String? value) {
    for (int i = 0; i < EntryRejectionReasons.values.length; i++) {
      if (EntryRejectionReasons.values[i].name == value) {
        return EntryRejectionReasons.values[i];
      }
    }
    return EntryRejectionReasons.sconosciuto;
  }

  static String toPrettyString(EntryRejectionReasons entryRejectionReasons) {
    switch (entryRejectionReasons) {
      case EntryRejectionReasons.accessiGiornalieriEsauriti:
        return "Accessi giornalieri esauriti";
      case EntryRejectionReasons.accessiDisponibiliEsauriti:
        return "Accessi disponibili esauriti";
      case EntryRejectionReasons.fuoriFasciaOraria:
        return "Fuori fascia oraria";
      case EntryRejectionReasons.sconosciuto:
        return "Sconosciuto";
    }
  }
}
