import 'package:gym_manager_core/core.dart';

class BackupShift {
  int dayOfWeek;
  TimeOfDay start;
  TimeOfDay end;

  BackupShift({
    required this.dayOfWeek,
    required this.start,
    required this.end,
  });

  factory BackupShift.fromJson(Map<String, dynamic> json) {
    return BackupShift(
      dayOfWeek: json['dayOfWeek'] as int,
      start: TimeOfDay.fromString(json['start']),
      end: TimeOfDay.fromString(json['end']),
    );
  }
}
