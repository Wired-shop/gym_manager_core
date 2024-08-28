class Course {
  int? id;
  String name;

  Course({this.id, required this.name});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(id: json['id'] as int?, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
