enum ValidationResponse {
  valid,
  notValid,
  warnings;

  static String toPrettyString(ValidationResponse validationResponse) {
    if (validationResponse == ValidationResponse.warnings) {
      return "Problemi";
    } else if (validationResponse == ValidationResponse.notValid) {
      return "Non valido";
    } else {
      return "Valido";
    }
  }
}
