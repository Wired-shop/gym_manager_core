import 'package:gym_manager_backend/src/models/filter_field.dart';

abstract class Filter {
  final List<FilterField> fields;

  Filter(this.fields);

  setFieldValue({required String name, required dynamic value}) {
    List<FilterField> field = fields.where((e) => e.name == name).toList();
    if (field.isNotEmpty) {
      field.first.value = value;
    }
  }

  String toQueryParameters() {
    String query = '';
    for (int i = 0; i < fields.length; i++) {
      query +=
          "${query.isNotEmpty ? '&' : ''}${fields[i].name}=${fields[i].value}";
    }
    return query;
  }
}
