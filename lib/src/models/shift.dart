import 'package:gym_manager_core/src/models/time_of_day.dart';

class Shift {
  int? id;
  int courseId;
  int dayOfWeek;
  TimeOfDay start;
  TimeOfDay end;
  int? maxSeats;
  String? name;
  String? trainer;
  int bookable;
  String? gymId;
  int? bookableOffsetMinutes;

  Shift({
    this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.start,
    required this.end,
    this.maxSeats,
    this.name,
    this.trainer,
    required this.bookable,
    this.gymId,
    this.bookableOffsetMinutes,
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
      bookable: json['bookable'] as int,
      gymId: json['gymId'] as String?,
      bookableOffsetMinutes: json['bookableOffsetMinutes'] as int?,
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
      'trainer': trainer,
      'name': name,
      'bookable': bookable,
      'gymId': gymId,
      'bookableOffsetMinutes': bookableOffsetMinutes,
    };
  }

  DateTime get nextBookableOccurrence {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dartDow = dayOfWeek == 0 ? 7 : dayOfWeek;
    final daysUntil = (dartDow - today.weekday + 7) % 7;
    final date = daysUntil == 0 ? today : today.add(Duration(days: daysUntil));
    return DateTime(date.year, date.month, date.day, start.hour, start.minute);
  }

  DateTime get nextOccurrence => DateTime(
        nextBookableOccurrence.year,
        nextBookableOccurrence.month,
        nextBookableOccurrence.day,
      );

  bool get isBookable {
    if (bookable != 1) return false;
    if (bookableOffsetMinutes == null) return true;
    return !DateTime.now().isBefore(
      nextBookableOccurrence.subtract(
        Duration(minutes: bookableOffsetMinutes!),
      ),
    );
  }

  DateTime? get bookableFromDate {
    if (bookableOffsetMinutes == null) return null;
    return nextBookableOccurrence.subtract(
      Duration(minutes: bookableOffsetMinutes!),
    );
  }

  @override
  String toString() => toJson().toString();
}
