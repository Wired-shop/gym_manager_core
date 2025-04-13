import 'package:gym_manager_core/src/models/time_of_day.dart';

class BookableShift {
  int? id;
  int shiftId;
  DateTime date;

  BookableShift({
    this.id,
    required this.shiftId,
    required this.date,
  });

  factory BookableShift.fromJson(Map<String, dynamic> json) {
    return BookableShift(
      id: json['id'] as int?,
      shiftId: json['shiftId'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shiftId': shiftId,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
