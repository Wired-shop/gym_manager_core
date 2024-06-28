// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryResult _$EntryResultFromJson(Map<String, dynamic> json) => EntryResult(
      $enumDecode(_$EntryResponseEnumMap, json['response']),
      (json['warnings'] as List<dynamic>)
          .map((e) => $enumDecode(_$EntryResponseWarningsEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$EntryResultToJson(EntryResult instance) =>
    <String, dynamic>{
      'response': _$EntryResponseEnumMap[instance.response]!,
      'warnings': instance.warnings
          .map((e) => _$EntryResponseWarningsEnumMap[e]!)
          .toList(),
    };

const _$EntryResponseEnumMap = {
  EntryResponse.valid: 'valid',
  EntryResponse.notValid: 'notValid',
};

const _$EntryResponseWarningsEnumMap = {
  EntryResponseWarnings.iscrizioneScaduta: 'iscrizioneScaduta',
  EntryResponseWarnings.affiliazioneScaduta: 'affiliazioneScaduta',
  EntryResponseWarnings.certificatoMedicoScaduto: 'certificatoMedicoScaduto',
  EntryResponseWarnings.iscrizioneAssente: 'iscrizioneAssente',
  EntryResponseWarnings.affiliazioneAssente: 'affiliazioneAssente',
  EntryResponseWarnings.certificatoMedicoAssente: 'certificatoMedicoAssente',
  EntryResponseWarnings.abbonamentoAssente: 'abbonamentoAssente',
  EntryResponseWarnings.abbonamentoScaduto: 'abbonamentoScaduto',
  EntryResponseWarnings.accessiTerminati: 'accessiTerminati',
  EntryResponseWarnings.sconosciuto: 'sconosciuto',
};
