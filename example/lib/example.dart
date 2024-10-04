import 'package:gym_manager_core/core.dart';

int gymId = 1;
String email = "patrick1@gmail.com";
String password = "ciao1234";

void main(List<String> arguments) async {
  //Auth
  ApiService.getIstance().setUsername(email);
  ApiService.getIstance().setPassword(password);
  ApiService.getIstance().setGymId(1);

  //Users

  print(await UserRepository.insert(user: User(name: "Patrick")));

  print(await SubscriptionRepository.get(userId: 5));
}
