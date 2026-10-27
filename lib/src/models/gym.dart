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
  final String? openingHours;

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
        openingHours: json['openingHoursText'] as String? ??
            _parseOpeningHours(json['openingHours']),
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
        'openingHoursText': openingHours,
      };

  // The free text lives in "openingHoursText"; "openingHours" keeps the old
  // { monday: { open, close, open_afternoon?, close_afternoon? } | null, ... }
  // map for the installed versions, which cast it to a Map. Gyms without the
  // text yet get the map rendered as text.
  static String? _parseOpeningHours(dynamic value) {
    if (value == null || value is String) return value as String?;
    if (value is! Map) return null;
    const days = {
      'monday': 'Lunedì',
      'tuesday': 'Martedì',
      'wednesday': 'Mercoledì',
      'thursday': 'Giovedì',
      'friday': 'Venerdì',
      'saturday': 'Sabato',
      'sunday': 'Domenica',
    };
    return days.entries.where((d) => value.containsKey(d.key)).map((d) {
      final hours = value[d.key];
      if (hours is! Map) return '${d.value}: Chiuso';
      final afternoon = hours['open_afternoon'] != null
          ? ', ${hours['open_afternoon']} - ${hours['close_afternoon']}'
          : '';
      return '${d.value}: ${hours['open']} - ${hours['close']}$afternoon';
    }).join('\n');
  }
}
