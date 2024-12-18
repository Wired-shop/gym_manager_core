import 'package:gym_manager_core/core.dart';

int gymId = 1;
String email = "patrick1@gmail.com";
String password = "ciao1234";

void main(List<String> arguments) async {
  UsersFilter filter1 = UsersFilter(validationResponseWarnings: [
    ValidationResponseWarnings.abbonamentoAssente,
  ]);
  UsersFilter filter2 = UsersFilter(validationResponseWarnings: [
    ValidationResponseWarnings.abbonamentoAssente,
  ]);
  print(filter1.toJson().entries.toList());
  print(filter2.toJson().entries.toList());
  print(filter1 == filter2);
}
