import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setIP("127.0.0.1");
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setGymId("1");

  var email = "ptrnic@gmail.com";
  var password = "ciao1234";
  ApiService.getInstance().setEmail(email);
  ApiService.getInstance().setPassword(password);

  await BookingRepository.insert(Booking(
      shiftId: 1, courseId: 1, userId: 1, status: BookingStatus.notUsed));
}
