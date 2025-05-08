import 'package:gym_manager_core/core.dart';

class BackupShift {
  int dayOfWeek;
  TimeOfDay start;

  BackupShift({
    required this.dayOfWeek,
    required this.start,
  });

  factory BackupShift.fromJson(Map<String, dynamic> json) {
    return BackupShift(
      dayOfWeek: json['dayOfWeek'] as int,
      start: TimeOfDay.fromString(json['start']),
    );
  }

  toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'start': start.format24Hour(),
    };
  }

  String toCronExpression() {
    final minutes = start.minute;
    final hours = start.hour;
    final dow = dayOfWeek;
    return '$minutes $hours * * $dow';
  }
}
