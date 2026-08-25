class Notification {
  final String id;
  final String title;
  final String message;
  final String email;
  final String gymId;
  final bool visualizzato;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.email,
    required this.gymId,
    this.visualizzato = false,
  });

  Notification copyWith({bool? visualizzato}) {
    return Notification(
      id: id,
      title: title,
      message: message,
      email: email,
      gymId: gymId,
      visualizzato: visualizzato ?? this.visualizzato,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'email': email,
      'gymId': gymId,
      'visualizzato': visualizzato,
    };
  }

  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      email: json['email'],
      gymId: json['gymId'],
      visualizzato: json['visualizzato'] ?? false,
    );
  }

  @override
  toString() {
    return 'Notification{id: $id, title: $title, message: $message, email: $email, gymId: $gymId, visualizzato: $visualizzato}';
  }
}
