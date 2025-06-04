class CoursePlan {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int validityDays;
  final int courseId;

  CoursePlan({
    this.id,
    required this.courseId,
    required this.name,
    required this.description,
    required this.price,
    required this.validityDays,
  });

  factory CoursePlan.fromJson(Map<String, dynamic> json) {
    return CoursePlan(
      id: json['id'] as int?,
      courseId: json['courseId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      validityDays: json['validityDays'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
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
          id == other.id &&
          courseId == other.courseId &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          validityDays == other.validityDays;

  @override
  int get hashCode =>
      id.hashCode ^
      courseId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      validityDays.hashCode;
}
