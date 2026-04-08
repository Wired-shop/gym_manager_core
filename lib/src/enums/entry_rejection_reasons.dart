enum EntryRejectionReasons {
  accessiGiornalieriEsauriti,
  accessiDisponibiliEsauriti,
  fuoriFasciaOraria;

  String get label {
    switch (this) {
      case EntryRejectionReasons.accessiGiornalieriEsauriti:
        return "Accessi giornalieri esauriti";
      case EntryRejectionReasons.accessiDisponibiliEsauriti:
        return "Accessi disponibili esauriti";
      case EntryRejectionReasons.fuoriFasciaOraria:
        return "Fuori fascia oraria";
    }
  }
}
