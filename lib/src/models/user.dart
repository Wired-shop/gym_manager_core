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
  String? imagePath;
  String? medicalDocumentPath;
  String? affiliationDocumentPath;
  String? subscriptionDocumentPath;

  //Flags
  int? flagged;
  int? archived;
  int? tpPro;
  int? forceBlock;

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
    this.imagePath,
    this.medicalDocumentPath,
    this.affiliationDocumentPath,
    this.subscriptionDocumentPath,
    this.flagged,
    this.forceBlock,
    this.tpPro,
    this.archived,
    this.birthday,
    this.birthdayCity,
    this.gender,
    this.job,
    this.creation,
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
