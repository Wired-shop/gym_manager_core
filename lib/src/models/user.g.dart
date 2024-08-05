// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      address: json['address'] as String?,
      fiscalCode: json['fiscalCode'] as String?,
      city: json['city'] as String?,
      zipCode: json['zipCode'] as int?,
      province: json['province'] as String?,
      phone: json['phone'] as String?,
      phone2: json['phone2'] as String?,
      phone2Type: json['phone2Type'] as String?,
      phone3: json['phone3'] as String?,
      phone3Type: json['phone3Type'] as String?,
      email: json['email'] as String?,
      privateNote: json['privateNote'] as String?,
      publicNote: json['publicNote'] as String?,
      subscriptionExpiration: json['subscriptionExpiration'] == null
          ? null
          : DateTime.parse(json['subscriptionExpiration'] as String),
      affiliationExpiration: json['affiliationExpiration'] == null
          ? null
          : DateTime.parse(json['affiliationExpiration'] as String),
      medicalCertificateExpiration: json['medicalCertificateExpiration'] == null
          ? null
          : DateTime.parse(json['medicalCertificateExpiration'] as String),
      image: json['image'] as String?,
      medicalDocument: json['medicalDocument'] as String?,
      affiliationDocument: json['affiliationDocument'] as String?,
      subscriptionDocument: json['subscriptionDocument'] as String?,
      flagged: json['flagged'] as int?,
      archived: json['archived'] as int?,
      tpPro: json['tpPro'] as int?,
      id: json['id'] as int?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      gender: json['gender'] as String?,
      job: json['job'] as String?,
      validationResult: json['validationResult'] == null
          ? null
          : ValidationResult.fromJson(
              json['validationResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'birthday': instance.birthday?.toIso8601String(),
      'gender': instance.gender,
      'address': instance.address,
      'fiscalCode': instance.fiscalCode,
      'city': instance.city,
      'job': instance.job,
      'zipCode': instance.zipCode,
      'province': instance.province,
      'phone': instance.phone,
      'phone2': instance.phone2,
      'phone2Type': instance.phone2Type,
      'phone3': instance.phone3,
      'phone3Type': instance.phone3Type,
      'email': instance.email,
      'privateNote': instance.privateNote,
      'publicNote': instance.publicNote,
      'subscriptionExpiration':
          instance.subscriptionExpiration?.toIso8601String(),
      'affiliationExpiration':
          instance.affiliationExpiration?.toIso8601String(),
      'medicalCertificateExpiration':
          instance.medicalCertificateExpiration?.toIso8601String(),
      'image': instance.image,
      'medicalDocument': instance.medicalDocument,
      'affiliationDocument': instance.affiliationDocument,
      'subscriptionDocument': instance.subscriptionDocument,
      'flagged': instance.flagged,
      'archived': instance.archived,
      'tpPro': instance.tpPro,
      'validationResult': instance.validationResult?.toJson(),
    };
