enum ValidationResponse {
  valid,
  notValid,
  warnings;

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
