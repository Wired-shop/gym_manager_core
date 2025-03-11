import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setIP("127.0.0.1");
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setGymId("1");
  ApiService.getInstance().setEmail("patrick@gmail.com");
  ApiService.getInstance().setPassword("ciao1234");

  CourseRepository.stream().listen((_) {
    print(_);
  });
}
