enum BookingStatus {
  valid,
  notValid;

  static BookingStatus fromString(String value) {
    if (value == valid.name) {
      return BookingStatus.valid;
    } else {
      return BookingStatus.notValid;
    }
  }
}
