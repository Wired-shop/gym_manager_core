import 'package:gym_manager_core/core.dart';

class Booking {
  final int id;
  final String gymId;
  final int shiftId;
  final int userId;
  final int courseId;
  final DateTime shiftDate;
  final DateTime bookedAt;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.gymId,
    required this.shiftId,
    required this.userId,
    required this.courseId,
    required this.shiftDate,
    required this.bookedAt,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as int,
        gymId: json['gymId'] as String,
        shiftId: json['shiftId'] as int,
        userId: json['userId'] as int,
        courseId: json['shifts']['courseId'] as int, // ← dalla join
        shiftDate: DateTime.parse(json['shiftDate'] as String),
        bookedAt: DateTime.parse(json['bookedAt'] as String),
        status: BookingStatus.fromString(json['status'] as String),
      );
  // toJson rimane invariato
}
