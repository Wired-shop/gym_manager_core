import 'package:gym_manager_core/core.dart';

int gymId = 1;
String email = "patrick1@gmail.com";
String password = "ciao1234";

void main(List<String> arguments) async {
  //Auth
  ApiService.getIstance()
      .setAuthCredentials(username: email, password: password);
  ApiService.getIstance().setGymId(1);

  ApiService.getIstance().switchToLocal();
  ApiService.getIstance().switchToRemote();

  //Users
  print(await UserRepository.list());
  await UserRepository.insert(user: User(name: "Buh"));
  await UserRepository.delete(id: 3);

  //Subscritpion
  await SubscriptionRepository.insert(
      subscription: Subscription(expiration: DateTime.now(), userId: 5));

  //Entry
  await EntryRepository.insert(
      entry: Entry(
          userId: 1,
          subscriptionId: 2,
          date: DateTime.now(),
          response: EntryResponse.valid));

  //Couse
  await CourseRepository.insert(course: Course(name: "Zumba"));

  //Shift
  await ShiftRepository.insert(
      shift: Shift(courseId: 2, dayOfWeek: 1, start: "09:00", end: "10:00"));
}
