// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      userId: json['userId'] as int,
      subscriptionId: json['subscriptionId'] as int,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      result:
          json['result'] == null ? null : EntryResult.fromJson(json['result']),
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'userId': instance.userId,
      'subscriptionId': instance.subscriptionId,
      'date': instance.date?.toIso8601String(),
      'result': instance.result?.toJson()
    };
