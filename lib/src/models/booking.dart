import 'package:gym_manager_core/src/enums/booking_status.dart';

class Booking {
  int? id;
  int shiftId;
  int courseId;
  int userId;
  BookingStatus status;
  DateTime? date;

  Booking({
    this.id,
    required this.shiftId,
    required this.courseId,
    required this.userId,
    required this.status,
    this.date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int?,
      shiftId: json['shiftId'] as int,
      courseId: json['courseId'] as int,
      userId: json['userId'] as int,
      status: BookingStatus.fromString(json['status'] as String) ??
          BookingStatus.notUsed,
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
      'status': "notUsed",
      'date': date?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
