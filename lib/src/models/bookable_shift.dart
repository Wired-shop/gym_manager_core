class BookableShift {
  int? id;
  int shiftId;
  int courseId;
  DateTime date;

  BookableShift({
    this.id,
    required this.shiftId,
    required this.courseId,
    required this.date,
  });

  factory BookableShift.fromJson(Map<String, dynamic> json) {
    return BookableShift(
      id: json['id'] as int?,
      shiftId: json['shiftId'] as int,
      courseId: json['courseId'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shiftId': shiftId,
      'courseId': courseId,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
