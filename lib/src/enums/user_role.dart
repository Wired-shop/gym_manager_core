enum UserRole {
  unassigned,
  member,
  staff,
  admin;

  bool get isAssigned => this != UserRole.unassigned;
  bool get requiresPassword => isAssigned;
}
