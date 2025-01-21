import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setGymId("1");
  ApiService.getInstance().setIP("127.0.0.1");
  ApiService.getInstance().setPORT(3000);

  ApiService.getInstance().setUsername("patrick@gmail.com");
  ApiService.getInstance().setPassword("ciao1234");

  UsersFilter filter = UsersFilter(gender: "Maschio");

  Map<String, dynamic> map = {
    "id": 1,
    "userId": 1,
    "courseId": 3,
    "creation": "2028-01-13T00:00:00.000",
    "expiration": "2028-01-13T00:00:00.000",
    "badgeCode": null,
    "accessesAvaiable": null
  };
  Subscription sub = Subscription.fromJson(map);
  List<Course> courses = await CourseRepository.list();
  print("ciao");

  List<Subscription> subscriptions = await SubscriptionRepository.list();
  Subscription? subscriptions2 = await SubscriptionRepository.get(userId: 1);

  print("ciao");
}
