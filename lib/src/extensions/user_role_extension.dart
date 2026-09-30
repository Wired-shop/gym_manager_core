import 'package:gym_manager_core/src/enums/user_role.dart';

extension UserRoleExtension on UserRole {
  String get label => switch (this) {
        UserRole.unassigned => 'Nessuno',
        UserRole.member => 'Iscritto',
        UserRole.staff => 'Staff',
        UserRole.admin => 'Amministratore',
      };
}
