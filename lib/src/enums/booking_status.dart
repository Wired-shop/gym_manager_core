enum BookingStatus {
  confirmed,
  cancelled,
  used;

  static BookingStatus fromString(String value) => switch (value) {
    'confirmed' => BookingStatus.confirmed,
    'cancelled' => BookingStatus.cancelled,
    'used' => BookingStatus.used,
    _ => throw Exception('BookingStatus sconosciuto: $value'),
  };

  String toJson() => switch (this) {
    BookingStatus.confirmed => 'confirmed',
    BookingStatus.cancelled => 'cancelled',
    BookingStatus.used => 'used',
  };
}
