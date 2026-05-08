class Gym {
  final String gymId;
  final String name;
  final String? encodedImage;
  final String? address;
  final String? city;
  final String? phone;
  final String? email;
  final String? website;
  final String? instagram;
  final String? description;
  final Map<String, dynamic>? openingHours;

  const Gym({
    required this.gymId,
    required this.name,
    this.encodedImage,
    this.address,
    this.city,
    this.phone,
    this.email,
    this.website,
    this.instagram,
    this.description,
    this.openingHours,
  });

  factory Gym.fromJson(Map<String, dynamic> json, {required String gymId}) =>
      Gym(
        gymId: gymId,
        name: json['name'] as String,
        encodedImage: json['encodedImage'] as String?,
        address: json['address'] as String?,
        city: json['city'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        website: json['website'] as String?,
        instagram: json['instagram'] as String?,
        description: json['description'] as String?,
        openingHours: json['openingHours'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'gymId': gymId,
        'name': name,
        'encodedImage': encodedImage,
        'address': address,
        'city': city,
        'phone': phone,
        'email': email,
        'website': website,
        'instagram': instagram,
        'description': description,
        'openingHours': openingHours,
      };
}
