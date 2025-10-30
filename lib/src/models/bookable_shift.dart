import 'package:gym_manager_core/core.dart';

class BookableShift {
  int? id;
  Shift shift;
  Course course;
  DateTime date;

  BookableShift({
    this.id,
    required this.shift,
    required this.course,
    required this.date,
  });

  factory BookableShift.fromJson(Map<String, dynamic> json) {
    return BookableShift(
      id: json['id'] as int?,
      shift: Shift.fromJson(json['shift'] as Map<String, dynamic>),
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shift': shift.toJson(),
      'course': course.toJson(),
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
