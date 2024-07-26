import '../enums/validation_response.dart';
import '../enums/validation_response_warnings.dart';
import 'package:json_annotation/json_annotation.dart';
part 'validation_result.g.dart';

@JsonSerializable()
class ValidationResult {
  ValidationResponse response;
  List<ValidationResponseWarnings> warnings;

  ValidationResult(this.response, this.warnings);

  List<ValidationResponseWarnings> possibleWarnings() {
    if (response == ValidationResponse.notValid) {
      return [
        ValidationResponseWarnings.abbonamentoScaduto,
        ValidationResponseWarnings.affiliazioneScaduta,
        ValidationResponseWarnings.iscrizioneScaduta,
        ValidationResponseWarnings.certificatoMedicoScaduto,
        ValidationResponseWarnings.accessiTerminati,
        ValidationResponseWarnings.abbonamentoAssente,
      ];
    } else if (response == ValidationResponse.notValid) {
      return [
        ValidationResponseWarnings.affiliazioneAssente,
        ValidationResponseWarnings.iscrizioneAssente,
        ValidationResponseWarnings.certificatoMedicoAssente,
        ValidationResponseWarnings.affiliazioneInScadenza,
        ValidationResponseWarnings.abbonamentoInScadenza,
        ValidationResponseWarnings.iscrizioneInscadenza,
      ];
    }
    return [];
  }

  factory ValidationResult.fromJson(Map<String, dynamic> json) =>
      _$ValidationResultFromJson(json);
  Map<String, dynamic> toJson() => _$ValidationResultToJson(this);
}
