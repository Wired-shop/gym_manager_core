import 'package:gym_manager_core/core.dart';

class CoursePlan {
  final int? id;
  String? name;
  String? description;
  double price;
  int validityDays;
  Course course;

  CoursePlan({
    this.id,
    required this.course,
    this.name,
    this.description,
    required this.price,
    required this.validityDays,
  });
  factory CoursePlan.fromJson(Map<String, dynamic> json) {
    return CoursePlan(
      id: json['id'] as int?,
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] is String
          ? double.parse(json['price'])
          : (json['price'] as num).toDouble(),
      validityDays: json['validityDays'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'course': course.toJson(),
      'name': name,
      'description': description,
      'price': price,
      'validityDays': validityDays,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursePlan &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          course.toJson() == other.course.toJson() &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          validityDays == other.validityDays;

  @override
  int get hashCode =>
      id.hashCode ^
      course.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      validityDays.hashCode;

  @override
  String toString() {
    return toJson().toString();
  }
}
