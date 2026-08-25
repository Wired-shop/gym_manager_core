class Notification {
  final String id;
  final String title;
  final String? message;
  final String email;
  final String gymId;
  final bool viewed;

  Notification({
    required this.id,
    required this.title,
    this.message,
    required this.email,
    required this.gymId,
    this.viewed = false,
  });

  Notification copyWith({bool? viewed}) {
    return Notification(
      id: id,
      title: title,
      message: message,
      email: email,
      gymId: gymId,
      viewed: viewed ?? this.viewed,
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
    );
  }

  @override
  toString() {
    return 'Notification{id: $id, title: $title, message: $message, email: $email, gymId: $gymId, viewed: $viewed}';
  }
}
