class Plan {
  final int? id;
  String? name;
  String? description;
  double price;
  int? validityDays;
  int? accesses;
  int courseId;

  Plan({
    this.id,
    required this.courseId,
    this.name,
    this.description,
    required this.price,
    this.validityDays,
    this.accesses,
  });
  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as int?,
      courseId: json['courseId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] is String
          ? double.parse(json['price'])
          : (json['price'] as num).toDouble(),
      validityDays: json['validityDays'] as int?,
      accesses: json['accesses'] as int?,
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
      'accesses': accesses,
    };
  }

  String get durationLabel => [
        if (accesses != null) "$accesses ingressi",
        if (validityDays != null) "$validityDays giorni",
      ].join(" · ");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Plan &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          courseId == other.courseId &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          validityDays == other.validityDays &&
          accesses == other.accesses;

  @override
  int get hashCode =>
      id.hashCode ^
      courseId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      validityDays.hashCode ^
      accesses.hashCode;

  @override
  String toString() {
    return toJson().toString();
  }
}
