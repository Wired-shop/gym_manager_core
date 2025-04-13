class Booking {
  int? id;
  int shiftId;
  int courseId;
  int userId;
  DateTime? date;

  Booking({
    this.id,
    required this.shiftId,
    required this.courseId,
    required this.userId,
    this.date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int?,
      shiftId: json['shiftId'] as int,
      courseId: json['courseId'] as int,
      userId: json['userId'] as int,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shiftId': shiftId,
      'courseId': courseId,
      'userId': userId,
      'date': date?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
