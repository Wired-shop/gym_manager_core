import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  var localhost = "127.0.0.1";

  ApiService.getInstance().setIP(localhost);
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setGymId("pleiadi");

  var email = "pleiadisem@gmail.com";
  var password = "027ox%PWRAi!";
  ApiService.getInstance().setEmail(email);
  ApiService.getInstance().setPassword(password);

  List<CoursePlan> courses = await CoursePlanRepository.list(3);

  print(courses);
  print(await CoursePlanRepository.delete(4));

  courses = await CoursePlanRepository.list(3);

  print(courses);
}
