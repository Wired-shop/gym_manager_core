import 'package:gym_manager_backend/src/models/filter.dart';
import 'package:gym_manager_backend/src/models/filter_field.dart';

class UsersFilter extends Filter {
  UsersFilter()
      : super([
          FilterField(
            name: 'hasEmail',
            dbAttributeName: 'email',
            value: false,
          ),
          FilterField(
            name: 'hasPhone',
            dbAttributeName: 'phone',
            value: false,
          ),
          FilterField(
            name: 'hasPublicNote',
            dbAttributeName: 'publicNote',
            value: false,
          ),
          FilterField(
            name: 'hasPrivateNote',
            dbAttributeName: 'privateNote',
            value: false,
          ),
          FilterField(
            name: 'isArchived',
            dbAttributeName: 'archived',
            value: false,
          ),
          FilterField(
            name: 'isFlagged',
            dbAttributeName: 'flagged',
            value: false,
          ),
          FilterField(
            name: 'isTpPro',
            dbAttributeName: 'tpPro',
            value: false,
          ),
        ]);
}
