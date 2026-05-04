import 'package:gym_manager_core/src/models/time_of_day.dart';

class Shift {
  int? id;
  int courseId;
  int dayOfWeek;
  TimeOfDay start;
  TimeOfDay end;
  int? maxSeats;
  int? occupedSeats;
  String? name;
  String? trainer;
  int bookable;
  String? gymId;

  Shift({
    this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.start,
    required this.end,
    this.maxSeats,
    this.occupedSeats,
    this.name,
    this.trainer,
    required this.bookable,
    this.gymId,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] as int?,
      courseId: json['courseId'] as int,
      dayOfWeek: json['dayOfWeek'] as int,
      start: TimeOfDay.fromString(json['start']),
      end: TimeOfDay.fromString(json['end']),
      maxSeats: json['maxSeats'] as int?,
      trainer: json['trainer'] as String?,
      name: json['name'] as String?,
      bookable: (json['bookable'] as int),
      gymId: json['gymId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'dayOfWeek': dayOfWeek,
      'start': start.format24Hour(),
      'end': end.format24Hour(),
      'maxSeats': maxSeats,
      'occupedSeats': occupedSeats,
      'trainer': trainer,
      'name': name,
      'bookable': bookable,
      'gymId': gymId,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
