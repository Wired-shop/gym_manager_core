part of 'entry.dart';

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    id: json['id'] as int?,
    userId: json['userId'] as int,
    subscriptionId: json['subscriptionId'] as int,
    date: DateTime.parse(json['date'] as String),
    response: $enumDecode(_$EntryResponseEnumMap, json['response']),
    notEntryReasons: (json['notEntryReasons'] as List<dynamic>?)
        ?.map((e) => $enumDecode(_$EntryRejectionReasonEnumMap, e))
        .toList(),
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) {
  return <String, dynamic>{
    'id': instance.id,
    'userId': instance.userId,
    'subscriptionId': instance.subscriptionId,
    'date': instance.date.toIso8601String(),
    'response': _$EntryResponseEnumMap[instance.response]!,
    'notEntryReasons': instance.notEntryReasons
        ?.map((e) => _$EntryRejectionReasonEnumMap[e]!)
        .toList(),
  };
}

const _$EntryResponseEnumMap = {
  EntryResponse.valid: 'valid',
  EntryResponse.notValid: 'notValid',
};

const _$EntryRejectionReasonEnumMap = {
  EntryRejectionReason.accessiGiornalieriEsauriti: 'accessiGiornalieriEsauriti',
  EntryRejectionReason.accessiDisponibiliEsauriti: 'accessiDisponibiliEsauriti',
  EntryRejectionReason.fuoriFasciaOraria: 'fuoriFasciaOraria',
  EntryRejectionReason.bloccato: 'bloccato',
  EntryRejectionReason.iscrizioneScaduta: 'iscrizioneScaduta',
  EntryRejectionReason.affiliazioneScaduta: 'affiliazioneScaduta',
  EntryRejectionReason.certificatoMedicoScaduto: 'certificatoMedicoScaduto',
  EntryRejectionReason.iscrizioneAssente: 'iscrizioneAssente',
  EntryRejectionReason.affiliazioneAssente: 'affiliazioneAssente',
  EntryRejectionReason.certificatoMedicoAssente: 'certificatoMedicoAssente',
  EntryRejectionReason.abbonamentoAssente: 'abbonamentoAssente',
  EntryRejectionReason.abbonamentoScaduto: 'abbonamentoScaduto',
  EntryRejectionReason.accessiTerminati: 'accessiTerminati',
  EntryRejectionReason.iscrizioneInScadenza: 'iscrizioneInScadenza',
  EntryRejectionReason.abbonamentoInScadenza: 'abbonamentoInScadenza',
  EntryRejectionReason.affiliazioneInScadenza: 'affiliazioneInScadenza',
  EntryRejectionReason.certificatoMedicoInScadenza:
      'certificatoMedicoInScadenza',
  EntryRejectionReason.sconosciuto: 'sconosciuto',
};
