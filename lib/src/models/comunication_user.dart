class ComunicationUser {
  final String name;
  final String surname;
  final String? email;
  final String? phone;
  final bool? delivered;

  ComunicationUser({
    required this.name,
    required this.surname,
    this.email,
    this.phone,
    this.delivered,
  });

  ComunicationUser copyWith({bool? delivered}) => ComunicationUser(
        name: name,
        surname: surname,
        email: email,
        phone: phone,
        delivered: delivered ?? this.delivered,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'email': email,
        'phone': phone,
        'delivered': delivered,
      };

  factory ComunicationUser.fromJson(Map<String, dynamic> json) => ComunicationUser(
        name: json['name'] as String,
        surname: json['surname'] as String,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        delivered: json['delivered'] as bool?,
      );

  @override
  String toString() => toJson().toString();
}
