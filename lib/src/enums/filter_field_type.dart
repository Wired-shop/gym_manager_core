enum FilterFieldType {
  isField,
  hasField,
  unknown;

  static FilterFieldType fromValue(String? value) {
    for (int i = 0; i < FilterFieldType.values.length; i++) {
      if (FilterFieldType.values[i].name == value) {
        return FilterFieldType.values[i];
      }
    }
    return FilterFieldType.unknown;
  }
}
