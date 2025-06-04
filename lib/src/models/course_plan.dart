class CoursePlan {
  final String name;
  final String description;
  final double price;
  final int validityDays;
  final int courseId;

  CoursePlan({
    required this.courseId,
    required this.name,
    required this.description,
    required this.price,
    required this.validityDays,
  });

  factory CoursePlan.fromJson(Map<String, dynamic> json) {
    return CoursePlan(
      courseId: json['courseId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      validityDays: json['validityDays'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
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
          courseId == other.courseId &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          validityDays == other.validityDays;

  @override
  int get hashCode =>
      courseId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      validityDays.hashCode;
}
