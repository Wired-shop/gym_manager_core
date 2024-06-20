// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) =>
    ValidationResult(
      $enumDecode(_$ValidationResponseEnumMap, json['validationResponse']),
      (json['validationResponseWarnings'] as List<dynamic>)
          .map((e) => $enumDecode(_$ValidationResponseWarningsEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ValidationResultToJson(ValidationResult instance) =>
    <String, dynamic>{
      'validationResponse':
          _$ValidationResponseEnumMap[instance.validationResponse]!,
      'validationResponseWarnings': instance.validationResponseWarnings
          .map((e) => _$ValidationResponseWarningsEnumMap[e]!)
          .toList(),
    };

const _$ValidationResponseEnumMap = {
  ValidationResponse.valid: 'valid',
  ValidationResponse.notValid: 'notValid',
  ValidationResponse.warnings: 'warnings',
};

const _$ValidationResponseWarningsEnumMap = {
  ValidationResponseWarnings.iscrizioneScaduta: 'iscrizioneScaduta',
  ValidationResponseWarnings.affiliazioneScaduta: 'affiliazioneScaduta',
  ValidationResponseWarnings.certificatoMedicoScaduto:
      'certificatoMedicoScaduto',
  ValidationResponseWarnings.iscrizioneAssente: 'iscrizioneAssente',
  ValidationResponseWarnings.affiliazioneAssente: 'affiliazioneAssente',
  ValidationResponseWarnings.certificatoMedicoAssente:
      'certificatoMedicoAssente',
  ValidationResponseWarnings.abbonamentoAssente: 'abbonamentoAssente',
  ValidationResponseWarnings.abbonamentoScaduto: 'abbonamentoScaduto',
  ValidationResponseWarnings.accessiTerminati: 'accessiTerminati',
  ValidationResponseWarnings.bloccato: 'bloccato',
  ValidationResponseWarnings.abbonamentoInScadenza: 'abbonamentoInScadenza',
  ValidationResponseWarnings.iscrizioneInscadenza: 'iscrizioneInscadenza',
  ValidationResponseWarnings.affiliazioneInScadenza: 'affiliazioneInScadenza',
  ValidationResponseWarnings.certificatoMedicoInScadenza:
      'certificatoMedicoInScadenza',
};
