import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setGymId("1");
  ApiService.getInstance().setIP("127.0.0.1");
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setUsername("patrick@gmail.com");
  ApiService.getInstance().setPassword("ciao1234");

  UsersFilter filter = UsersFilter(gender: "Maschio");

  print(filter.toQueryParameters());
  print((await UserRepository.list(filter: filter))
      .map((e) => "${e.name} ${e.surname}"));
}
