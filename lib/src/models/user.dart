import 'validation_result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  //Ids
  int? id;

//Informations
  String? name;
  String? surname;
  String? birthdayCity;
  DateTime? birthday;
  String? gender;
  String? job;

//Address
  String? fiscalCode;
  String? address;
  String? city;
  int? zipCode;
  String? province;

//Contacts
  String? phone;
  String? phone2;
  String? phone2Type;
  String? phone3;
  String? phone3Type;
  String? email;

//Notes
  String? privateNote;
  String? publicNote;

  //Expirations
  DateTime? subscriptionExpiration;
  DateTime? affiliationExpiration;
  DateTime? medicalCertificateExpiration;

  //Files
  String? image;
  String? medicalDocument;
  String? affiliationDocument;
  String? subscriptionDocument;

  //Flags
  int? flagged;
  int? archived;
  int? tpPro;
  int? forceBlock;

  //Validaition
  ValidationResult? validationResult;

  DateTime? creation;

  User({
    this.id,
    this.name,
    this.surname,
    this.address,
    this.fiscalCode,
    this.city,
    this.zipCode,
    this.province,
    this.phone,
    this.phone2,
    this.phone2Type,
    this.phone3,
    this.phone3Type,
    this.email,
    this.privateNote,
    this.publicNote,
    this.subscriptionExpiration,
    this.affiliationExpiration,
    this.medicalCertificateExpiration,
    this.image,
    this.medicalDocument,
    this.affiliationDocument,
    this.subscriptionDocument,
    this.flagged,
    this.forceBlock,
    this.tpPro,
    this.archived,
    this.birthday,
    this.birthdayCity,
    this.gender,
    this.job,
    this.creation,
    this.validationResult,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
