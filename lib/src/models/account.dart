class Account {
  String email;
  String? gymId;
  String? name;
  String? encodedImage;
  AccountRole? role;

  Account({
    required this.email,
    this.gymId,
    this.name,
    this.encodedImage,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'gymId': gymId,
      'name': name,
      'encodedImage': encodedImage,
      'role': role?.name,
    };
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      email: map['email'] as String,
      gymId: map['gymId'] as String?,
      name: map['name'] as String?,
      encodedImage: map['encodedImage'] as String?,
      role: map['role'] == AccountRole.admin.name
          ? AccountRole.admin
          : AccountRole.user,
    );
  }
  @override
  String toString() {
    return toJson().toString();
  }
}

enum AccountRole {
  admin,
  user;
}
