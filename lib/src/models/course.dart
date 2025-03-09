class Course {
  int? id;
  String name;
  String? description;
  String? imageUrl;
  String? difficulty;
  String? trainer;
  int? kcal;
  int? meanDuration;

  Course(
      {this.id,
      required this.name,
      this.description,
      this.imageUrl,
      this.difficulty,
      this.trainer,
      this.meanDuration,
      this.kcal});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      difficulty: json['difficulty'] as String?,
      trainer: json['trainer'] as String?,
      kcal: json['kcal'] as int?,
      meanDuration: json['meanDuration'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'description': description,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
      'trainer': trainer,
      'kcal': kcal,
      'meanDuration': meanDuration
    };
  }
}
