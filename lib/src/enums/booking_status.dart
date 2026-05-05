enum BookingStatus {
  confirmed,
  used;

  static BookingStatus fromString(String value) => switch (value) {
        'confirmed' => BookingStatus.confirmed,
        'used' => BookingStatus.used,
        _ => throw Exception('BookingStatus sconosciuto: $value'),
      };

  String toJson() => switch (this) {
        BookingStatus.confirmed => 'confirmed',
        BookingStatus.used => 'used',
      };
}
