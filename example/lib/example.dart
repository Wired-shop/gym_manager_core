import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  UsersFilter filter1 = UsersFilter(validationResponseWarnings: [
    ValidationResponseWarnings.abbonamentoAssente,
  ]);
  UsersFilter filter2 = UsersFilter(validationResponseWarnings: [
    ValidationResponseWarnings.abbonamentoAssente,
    ValidationResponseWarnings.abbonamentoAssente,
  ]);
  print(filter1.toJson().entries.toList());
  print(filter2.toJson().entries.toList());
  print(filter1 == filter2);

  UsersFilter filter3 = UsersFilter();
  print(filter3.toJson().entries.toList());

  print(filter3.isClear());
}
