class CampaignUser {
  final String name;
  final String surname;
  final String? email;
  final String? phone;

  CampaignUser({
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

  factory CampaignUser.fromJson(Map<String, dynamic> json) => CampaignUser(
        name: json['name'] as String,
        surname: json['surname'] as String,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
      );

  @override
  String toString() => toJson().toString();
}
