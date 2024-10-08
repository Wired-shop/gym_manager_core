import 'package:gym_manager_core/core.dart';

int gymId = 1;
String email = "patrick1@gmail.com";
String password = "ciao1234";

void main(List<String> arguments) async {
  //Auth
  ApiService.getIstance().setUsername(email);
  ApiService.getIstance().setPassword(password);
  ApiService.getIstance().setGymId("1");

  Shift shift = await ShiftRepository.insert(
      shift: Shift(courseId: 20, dayOfWeek: 1, start: "11:20", end: "12:00"));

  print((await ShiftRepository.get(id: shift.id!))?.toJson());
}
