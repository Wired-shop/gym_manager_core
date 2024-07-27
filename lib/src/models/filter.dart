import 'package:gym_manager_backend/src/models/filter_field.dart';

class Filter {
  final List<FilterField> fields;

  Filter(this.fields);

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
    return Filter(json['fields']);
  }

  Map<String, dynamic> toJson() {
    return {
      "fields": fields.map((e) => e.toJson()).toList(),
    };
  }
}
