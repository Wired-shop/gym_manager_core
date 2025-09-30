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

  Course(
      {this.id,
      required this.name,
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
