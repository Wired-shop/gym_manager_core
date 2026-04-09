// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) =>
    ValidationResult(
      $enumDecode(_$ValidationResponseEnumMap, json['response']),
      (json['warnings'] as List<dynamic>)
          .map((e) => $enumDecode(_$ValidationResponseWarningsEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ValidationResultToJson(ValidationResult instance) =>
    <String, dynamic>{
      'response': _$ValidationResponseEnumMap[instance.response]!,
      'warnings': instance.warnings
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
  ValidationResponseWarnings.abbonamentoInScadenza: 'abbonamentoInScadenza',
  ValidationResponseWarnings.affiliazioneInScadenza: 'affiliazioneInScadenza',
  ValidationResponseWarnings.iscrizioneInScadenza: 'iscrizioneInScadenza',
  ValidationResponseWarnings.certificatoMedicoInScadenza:
      'certificatoMedicoInScadenza',
  ValidationResponseWarnings.abbonamentoScaduto: 'abbonamentoScaduto',
  ValidationResponseWarnings.accessiDisponibiliEsauriti:
      'accessiDisponibiliEsauriti',
  ValidationResponseWarnings.sconosciuto: 'sconosciuto',
};
