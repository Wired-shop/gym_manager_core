class Reservation {
  int? id;
  int shiftId;
  int courseId;
  int userId;
  DateTime? dateTime;

  Reservation({
    this.id,
    required this.shiftId,
    required this.courseId,
    required this.userId,
    this.dateTime,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as int?,
      shiftId: json['shiftId'] as int,
      courseId: json['courseId'] as int,
      userId: json['userId'] as int,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shiftId': shiftId,
      'courseId': courseId,
      'userId': userId,
      'dateTime': dateTime?.toIso8601String(),
    };
  }
}
