import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setIP("127.0.0.1");
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setGymId("pleiadi");

  var email = "ptrnic@gmail.com";
  var password = "ciao1234";
  ApiService.getInstance().setEmail(email);
  ApiService.getInstance().setPassword(password);

  List<Shift> shifts = await ShiftRepository.list(courseId: 1);
  print(shifts);

  List<Reservation> reservations =
      await ReservationRepository.list(dateTime: DateTime(2025, 05, 11));
  print(reservations);
}
