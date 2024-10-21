class Course {
  int? id;
  String name;
  String? description;
  String? imageUrl;

  Course({this.id, required this.name, this.description, this.imageUrl});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'description': description,
      'imageUrl': imageUrl
    };
  }
}
