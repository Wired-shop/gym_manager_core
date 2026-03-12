// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    id: json['id'] as int?,
    userId: json['userId'] as int,
    subscriptionId: json['subscriptionId'] as int,
    date: DateTime.parse(json['date'] as String),
    response: $enumDecode(_$EntryResponseEnumMap, json['response']),
    notEntryReason: json['notEntryReason'] as String?,
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) {
  return <String, dynamic>{
    'id': instance.id,
    'userId': instance.userId,
    'subscriptionId': instance.subscriptionId,
    'date': instance.date.toIso8601String(),
    'response': _$EntryResponseEnumMap[instance.response]!,
    'notEntryReason': instance.notEntryReason,
  };
}

const _$EntryResponseEnumMap = {
  EntryResponse.valid: 'valid',
  EntryResponse.notValid: 'notValid',
};
