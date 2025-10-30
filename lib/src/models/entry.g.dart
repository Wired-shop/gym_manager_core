// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    id: json['id'] as int?,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    subscription:
        Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    date: DateTime.parse(json['date'] as String),
    response: $enumDecode(_$EntryResponseEnumMap, json['response']),
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) {
  return <String, dynamic>{
    'id': instance.id,
    'user': instance.user.toJson(),
    'subscription': instance.subscription.toJson(),
    'date': instance.date.toIso8601String(),
    'response': _$EntryResponseEnumMap[instance.response]!,
  };
}

const _$EntryResponseEnumMap = {
  EntryResponse.valid: 'valid',
  EntryResponse.notValid: 'notValid',
};
