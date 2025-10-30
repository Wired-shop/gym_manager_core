import 'package:gym_manager_core/core.dart';
import 'package:gym_manager_core/src/enums/booking_status.dart';

class Booking {
  int? id;
  Shift shift;
  Course course;
  User user;
  BookingStatus status;
  DateTime? date;

  Booking({
    this.id,
    required this.shift,
    required this.course,
    required this.user,
    required this.status,
    required this.date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int?,
      shift: Shift.fromJson(json['shift'] as Map<String, dynamic>),
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      status: BookingStatus.fromString(json['status'] as String) ??
          BookingStatus.notUsed,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shift': shift.toJson(),
      'course': course.toJson(),
      'user': user.toJson(),
      'status': "notUsed",
      'date': date?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
