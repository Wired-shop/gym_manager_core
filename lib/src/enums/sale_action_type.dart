enum SaleActionType {
  installmentPaid,
  installmentUnpaid,
  salePaid,
  saleUnpaid,
  saleDeleted;

  static SaleActionType fromString(String value) {
    return SaleActionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('SaleActionType sconosciuto: $value'),
    );
  }

  @override
  String toString() {
    switch (this) {
      case SaleActionType.installmentPaid:
        return "Rata saldata";
      case SaleActionType.installmentUnpaid:
        return "Rata non più saldata";
      case SaleActionType.salePaid:
        return "Vendita saldata";
      case SaleActionType.saleUnpaid:
        return "Vendita non più saldata";
      case SaleActionType.saleDeleted:
        return "Vendita eliminata";
    }
  }
}
