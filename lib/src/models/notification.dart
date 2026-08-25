class Notification {
  final String id;
  final String title;
  final String? message;
  final String email;
  final String gymId;
  final bool viewed;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    this.message,
    required this.email,
    required this.gymId,
    this.viewed = false,
    required this.createdAt,
  });

  Notification copyWith({bool? viewed}) {
    return Notification(
      id: id,
      title: title,
      message: message,
      email: email,
      gymId: gymId,
      viewed: viewed ?? this.viewed,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'email': email,
      'gymId': gymId,
      'viewed': viewed,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      email: json['email'],
      gymId: json['gymId'],
      viewed: json['viewed'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  toString() {
    return 'Notification{id: $id, title: $title, message: $message, email: $email, gymId: $gymId, viewed: $viewed, createdAt: $createdAt}';
  }
}
