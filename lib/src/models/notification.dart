class Notification {
  final String title;
  final String message;
  final String email;
  final String gymId;

  Notification({
    required this.title,
    required this.message,
    required this.email,
    required this.gymId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'email': email,
      'gymId': gymId,
    };
  }

  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      message: json['message'],
      email: json['email'],
      gymId: json['gymId'],
    );
  }

  @override
  toString() {
    return 'Notification{title: $title, message: $message, email: $email, gymId: $gymId}';
  }
}
