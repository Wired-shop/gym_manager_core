import 'package:gym_manager_core/src/models/time_of_day.dart';

class Shift {
  int? id;
  int courseId;
  int dayOfWeek;
  TimeOfDay start;
  TimeOfDay end;
  int? maxSeats;
  int occupiedSeats;
  String? name;
  String? trainer;
  bool bookable;
  String? gymId;

  Shift({
    this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.start,
    required this.end,
    this.maxSeats,
    this.name,
    this.occupiedSeats = 0,
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
      occupiedSeats: json['occupiedSeats'] as int? ?? 0,
      trainer: json['trainer'] as String?,
      name: json['name'] as String?,
      bookable: (json['bookable'] as int) == 1 ? true : false,
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
      'occupiedSeats': occupiedSeats,
      'trainer': trainer,
      'name': name,
      'bookable': bookable == true ? 1 : 0,
      'gymId': gymId,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
