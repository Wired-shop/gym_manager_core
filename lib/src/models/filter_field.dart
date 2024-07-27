import 'package:gym_manager_backend/src/enums/filter_field_type.dart';

class FilterField {
  String name;
  String dbAttributeName;
  FilterFieldType? fieldType;
  bool value;

  FilterField({
    required this.name,
    required this.dbAttributeName,
    this.fieldType,
    required this.value,
  }) {
    if (name.contains('has')) {
      fieldType = FilterFieldType.hasField;
    } else if (name.contains('is')) {
      fieldType = FilterFieldType.isField;
    }
  }
}
