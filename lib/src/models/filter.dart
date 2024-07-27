import 'package:gym_manager_backend/src/models/filter_field.dart';

class Filter {
  final String? name;
  final List<FilterField> fields;

  Filter({required this.fields, this.name});

  setFieldValue({required String name, required dynamic value}) {
    List<FilterField> field = fields.where((e) => e.name == name).toList();
    if (field.isNotEmpty) {
      field.first.value = value;
    }
  }

  bool? getFieldValue(String name) {
    List<FilterField> field = fields.where((e) => e.name == name).toList();
    if (field.isNotEmpty) {
      return field.first.value;
    }
    return null;
  }

  String toQueryParameters() {
    String query = '';
    for (int i = 0; i < fields.length; i++) {
      query +=
          "${query.isNotEmpty ? '&' : ''}${fields[i].name}=${fields[i].value}";
    }
    return query;
  }

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      name: json.containsKey('name') ? json['name'] : null,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => FilterField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fields': fields.map((e) => e.toJson()).toList(),
    };
  }
}
