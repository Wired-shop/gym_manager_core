import 'package:gym_manager_core/core.dart';

class Course {
  int? id;
  String name;
  String? description;
  String? encodedImage;
  String? difficulty;
  String? trainer;
  int? kcal;
  int? meanDuration;
  int? dailyAccesses;
  List<Shift> shifts;

  Course(
      {this.id,
      required this.name,
      required this.shifts,
      this.description,
      this.encodedImage,
      this.difficulty,
      this.trainer,
      this.meanDuration,
      this.kcal,
      this.dailyAccesses});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      name: json['name'] as String,
      shifts: json['shifts'] != null
          ? (json['shifts'] as List)
              .map((e) => Shift.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      description: json['description'] as String?,
      encodedImage: json['encodedImage'] as String?,
      difficulty: json['difficulty'] as String?,
      trainer: json['trainer'] as String?,
      kcal: json['kcal'] as int?,
      meanDuration: json['meanDuration'] as int?,
      dailyAccesses: json['dailyAccesses'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'shifts': shifts.map((e) => e.toJson()).toList(),
      'id': id,
      'description': description,
      'encodedImage': encodedImage,
      'difficulty': difficulty,
      'trainer': trainer,
      'kcal': kcal,
      'meanDuration': meanDuration,
      'dailyAccesses': dailyAccesses,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
