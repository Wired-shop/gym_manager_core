import 'dart:convert';

class Account {
  String? gymId;

  String username;
  String password;

  Account(
      {required this.username, required this.password, required this.gymId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'gymId': gymId
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      username: map['username'] as String,
      password: map['password'] as String,
      gymId: map['gymId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {"username": username, "password": password};

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum AccountRole {
  admin,
  user;
}
