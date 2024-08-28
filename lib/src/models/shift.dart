class Shift {
  int id;
  int courseId;
  int dayOfWeek;
  int hour;
  int minute;

  Shift({
    required this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.hour,
    required this.minute,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] as int,
      courseId: json['courseId'] as int,
      dayOfWeek: json['dayOfWeek'] as int,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'dayOfWeek': dayOfWeek,
      'hour': hour,
      'minute': minute,
    };
  }
}
