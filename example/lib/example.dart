import 'package:gym_manager_core/core.dart';

int gymId = 1;
String email = "patrick1@gmail.com";
String password = "ciao1234";

void main(List<String> arguments) async {
  //Auth
  ApiService.getInstance().setUsername(email);
  ApiService.getInstance().setPassword(password);
  ApiService.getInstance().setGymId("1");
}
