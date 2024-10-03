class Shift {
  int? id;
  int? courseId;
  int dayOfWeek;
  String start;
  String end;

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
      start: json['start'].toString(),
      end: json['end'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'dayOfWeek': dayOfWeek,
      'start': start,
      'end': end,
    };
  }
}
