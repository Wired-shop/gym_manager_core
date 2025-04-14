enum BookingStatus {
  valid,
  notValid;

  static BookingStatus? fromString(String value) {
    if (value == valid.name) {
      return BookingStatus.valid;
    } else if (value == notValid.name) {
      return BookingStatus.notValid;
    }
    return null;
  }
}
