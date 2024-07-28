enum ValidationResponse {
  valid,
  notValid,
  warnings;

  static ValidationResponse? fromValue(String? value) {
    for (int i = 0; i < ValidationResponse.values.length; i++) {
      if (ValidationResponse.values[i].name == value) {
        return ValidationResponse.values[i];
      }
    }
    return null;
  }

  static String toPrettyString(ValidationResponse validationResponse) {
    switch (validationResponse) {
      case ValidationResponse.warnings:
        return "Problemi";
      case ValidationResponse.notValid:
        return "Non valido";
      case ValidationResponse.valid:
        return "Valido";
    }
  }
}
