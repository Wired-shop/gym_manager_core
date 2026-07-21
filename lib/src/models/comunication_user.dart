class ComunicationUser {
  final String name;
  final String surname;
  final String? email;
  final String? phone;

  ComunicationUser({
    required this.name,
    required this.surname,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'email': email,
        'phone': phone,
      };

  factory ComunicationUser.fromJson(Map<String, dynamic> json) => ComunicationUser(
        name: json['name'] as String,
        surname: json['surname'] as String,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
      );

  @override
  String toString() => toJson().toString();
}
