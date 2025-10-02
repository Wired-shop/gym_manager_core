import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  var localhost = "127.0.0.1";

  ApiService.getInstance().setIP(localhost);
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setGymId("pleiadi");

  var email = "pleiadisem@gmail.com";
  var password = "TAljKNWf8xYiG5AN";
  ApiService.getInstance().setEmail(email);
  ApiService.getInstance().setPassword(password);

  await EntryRepository.insert(
    Entry(
      userId: 943,
      subscriptionId: 960,
      date: DateTime.now(),
      response: EntryResponse.notValid,
    ),
  );

  print(Entry(
    userId: 943,
    subscriptionId: 960,
    date: DateTime.now(),
    response: EntryResponse.notValid,
  ).toJson());
}
