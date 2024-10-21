import 'package:gym_manager_core/src/models/time_of_day.dart';

class Shift {
  int? id;
  int? courseId;
  int dayOfWeek;
  TimeOfDay start;
  TimeOfDay end;

  Shift({
    this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.start,
    required this.end,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] as int?,
      courseId: json['courseId'] as int?,
      dayOfWeek: json['dayOfWeek'] as int,
      start: TimeOfDay.fromString(json['start']),
      end: TimeOfDay.fromString(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'dayOfWeek': dayOfWeek,
      'start': start.toString(),
      'end': end.toString(),
    };
  }
}
