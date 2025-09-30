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

  SyncUtils.syncTo(
    ip: "app1.wired-shop.com",
    users: await UserRepository.list(),
    subscriptions: await SubscriptionRepository.list(),
    courses: await CourseRepository.list(),
    shifts: await ShiftRepository.list(),
    bookableShifts: await BookableShiftRepository.list(),
  );
}
