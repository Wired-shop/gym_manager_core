import 'package:gym_manager_backend/src/enums/filter_field_type.dart';
import 'package:gym_manager_backend/src/models/filter.dart';
import 'package:gym_manager_backend/src/models/filter_field.dart';

class UsersFilter extends Filter {
  UsersFilter()
      : super(
          [
            FilterField(
              name: 'hasEmail',
              dbAttributeName: 'email',
              value: false,
              fieldType: FilterFieldType.hasField,
            ),
            FilterField(
              name: 'hasPhone',
              dbAttributeName: 'phone',
              value: false,
              fieldType: FilterFieldType.hasField,
            ),
            FilterField(
              name: 'hasPublicNote',
              dbAttributeName: 'publicNote',
              value: false,
              fieldType: FilterFieldType.hasField,
            ),
            FilterField(
              name: 'hasPrivateNote',
              dbAttributeName: 'privateNote',
              value: false,
              fieldType: FilterFieldType.hasField,
            ),
            FilterField(
              name: 'isArchived',
              dbAttributeName: 'archived',
              value: false,
              fieldType: FilterFieldType.isField,
            ),
            FilterField(
              name: 'isFlagged',
              dbAttributeName: 'flagged',
              value: false,
              fieldType: FilterFieldType.isField,
            ),
            FilterField(
              name: 'isTpPro',
              dbAttributeName: 'tpPro',
              value: false,
              fieldType: FilterFieldType.isField,
            ),
          ],
        );
}
