enum BookingStatus {
  notUsed,
  used;

  static BookingStatus? fromString(String value) {
    if (value == used.name) {
      return BookingStatus.used;
    } else if (value == notUsed.name) {
      return BookingStatus.notUsed;
    }
    return null;
  }

  static String toPrettyString(BookingStatus status) {
    if (status.name == BookingStatus.used.name) return "Non usata";
    return "Usata";
  }
}
