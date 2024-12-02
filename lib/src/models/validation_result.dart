import '../enums/validation_response.dart';
import '../enums/validation_response_warnings.dart';
import 'package:json_annotation/json_annotation.dart';
part 'validation_result.g.dart';

@JsonSerializable()
class ValidationResult {
  ValidationResponse response;
  List<ValidationResponseWarnings> warnings;

  ValidationResult(this.response, this.warnings);

  static List<ValidationResponseWarnings>? associatedWarningsOf(
      ValidationResponse? response) {
    if (response == ValidationResponse.notValid) {
      return [
        ValidationResponseWarnings.abbonamentoScaduto,
        ValidationResponseWarnings.affiliazioneScaduta,
        ValidationResponseWarnings.iscrizioneScaduta,
        ValidationResponseWarnings.certificatoMedicoScaduto,
        ValidationResponseWarnings.accessiTerminati,
        ValidationResponseWarnings.abbonamentoAssente,
      ];
    } else if (response == ValidationResponse.warnings) {
      return [
        ValidationResponseWarnings.affiliazioneAssente,
        ValidationResponseWarnings.iscrizioneAssente,
        ValidationResponseWarnings.certificatoMedicoAssente,
        ValidationResponseWarnings.abbonamentoInScadenza,
        ValidationResponseWarnings.affiliazioneInScadenza,
        ValidationResponseWarnings.iscrizioneInScadenza,
        ValidationResponseWarnings.certificatoMedicoInScadenza
      ];
    } else if (response == ValidationResponse.valid) {
      return [];
    }
    return null;
  }

  static ValidationResponse fromAssociatedWarnings(
      List<ValidationResponseWarnings> warnings) {
    if (warnings.contains(ValidationResponseWarnings.accessiTerminati) ||
        (warnings.contains(ValidationResponseWarnings.abbonamentoScaduto)) ||
        (warnings.contains(ValidationResponseWarnings.affiliazioneScaduta)) ||
        (warnings
            .contains(ValidationResponseWarnings.certificatoMedicoScaduto)) ||
        (warnings.contains(ValidationResponseWarnings.iscrizioneScaduta))) {
      return ValidationResponse.notValid;
    }
    if (warnings.isNotEmpty) {
      return ValidationResponse.warnings;
    }
    return ValidationResponse.valid;
  }

  factory ValidationResult.fromJson(Map<String, dynamic> json) =>
      _$ValidationResultFromJson(json);
  Map<String, dynamic> toJson() => _$ValidationResultToJson(this);
}
