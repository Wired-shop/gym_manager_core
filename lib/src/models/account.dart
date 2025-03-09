import 'dart:convert';

class Account {
  String email;
  String password;
  AccountRole? role;

  Account({
    required this.email,
    required this.password,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'role': role?.name,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'] as String,
      password: map['password'] as String,
      role: map['role'] == AccountRole.admin.name
          ? AccountRole.admin
          : AccountRole.user,
    );
  }

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum AccountRole {
  admin,
  user;
}
