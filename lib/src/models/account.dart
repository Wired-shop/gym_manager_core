class Account {
  String email;
  String password;
  String? imageUrl;
  AccountRole? role;

  Account({
    required this.email,
    required this.password,
    this.imageUrl,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'role': role?.name,
      'imageUrl': imageUrl,
    };
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      email: map['email'] as String,
      password: map['password'] as String,
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
