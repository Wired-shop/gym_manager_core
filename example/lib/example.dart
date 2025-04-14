import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setIP("192.168.1.36");
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setGymId("1");

  var email = "ptrnic@gmail.com";
  var password = "ciao1234";
  ApiService.getInstance().setEmail(email);
  ApiService.getInstance().setPassword(password);

  await SubscriptionRepository.truncate();
}
