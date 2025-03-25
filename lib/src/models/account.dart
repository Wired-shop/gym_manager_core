class Account {
  String email;
  String gymId;
  String password;
  String? imageUrl;
  AccountRole? role;

  Account({
    required this.email,
    required this.password,
    required this.gymId,
    this.imageUrl,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'gymId': gymId,
      'role': role?.name,
      'imageUrl': imageUrl,
    };
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      email: map['email'] as String,
      password: map['password'] as String,
      gymId: map['gymId'] as String,
      imageUrl: map['imageUrl'] as String?,
      role: map['role'] == AccountRole.admin.name
          ? AccountRole.admin
          : AccountRole.user,
    );
  }
}

enum AccountRole {
  admin,
  user;
}
