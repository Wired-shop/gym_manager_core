// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      courseId: json['courseId'] as int?,
      badgeCode: json['badgeCode'] as String?,
      accessesAvaiable: json['accessesAvaiable'] as int?,
      creation: DateTime.parse(json['creation'] as String),
      expiration: DateTime.parse(json['expiration'] as String),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'courseId': instance.courseId,
      'id': instance.id,
      'creation': instance.creation?.toIso8601String(),
      'expiration': instance.expiration.toIso8601String(),
      'badgeCode': instance.badgeCode,
      'accessesAvaiable': instance.accessesAvaiable,
    };
