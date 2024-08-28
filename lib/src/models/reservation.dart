class Reservation {
  int id;
  int shiftId;
  int userId;

  Reservation({required this.id, required this.shiftId, required this.userId});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as int,
      shiftId: json['shiftId'] as int,
      userId: json['userId'] as int,
    );
  }
}
