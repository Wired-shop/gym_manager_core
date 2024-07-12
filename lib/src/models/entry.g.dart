// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      userId: json['userId'] as int,
      subscriptionId: json['subscriptionId'] as int,
      date: DateTime.parse(json['date'] as String),
      response: $enumDecode(_$EntryResponseEnumMap, json['response']),
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'userId': instance.userId,
      'subscriptionId': instance.subscriptionId,
      'date': instance.date.toIso8601String(),
      'response': _$EntryResponseEnumMap[instance.response]!,
    };

const _$EntryResponseEnumMap = {
  EntryResponse.valid: 'valid',
  EntryResponse.notValid: 'notValid',
};
