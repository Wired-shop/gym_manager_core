import 'package:gym_manager_backend/src/enums/filter_field_type.dart';

class FilterField {
  String name;
  String dbAttributeName;
  FilterFieldType fieldType;
  bool value;

  FilterField({
    required this.name,
    required this.dbAttributeName,
    required this.fieldType,
    required this.value,
  }) {
    if (name.contains('has')) {
      fieldType = FilterFieldType.hasField;
    } else if (name.contains('is')) {
      fieldType = FilterFieldType.isField;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dbAttributeName': dbAttributeName,
      'fieldType': fieldType.name,
      'value': value,
    };
  }

  factory FilterField.fromJson(Map<String, dynamic> json) {
    return FilterField(
      name: json['name'],
      dbAttributeName: json['dbAttributeName'],
      value: json['value'],
      fieldType: FilterFieldType.fromValue(json['fieldType']),
    );
  }
}
