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

  List<Course> courses = await CourseRepository.list();

  Course course = courses[0];

  print(await CoursePlanRepository.insert(CoursePlan(
      courseId: course.id!,
      name: "Trimestrale",
      description: "Scade ogni 3 mesi",
      price: 12.09,
      validityDays: 30)));

  print(await CoursePlanRepository.list(course.id!));
}
