import 'package:gym_manager_core/core.dart';

class SyncUtils {
  static Future syncTo({
    required String ip,
    required List<User> users,
    required List<Subscription> subscriptions,
    required List<Course> courses,
    required List<Shift> shifts,
  }) async {
    //Save old infos
    String oldIp = ApiService.getInstance().getIP();
    ApiService.getInstance().setIP(ip);
    //Reset all table
    await UserRepository.truncate();
    await SubscriptionRepository.truncate();
    await CourseRepository.truncate();
    await ShiftRepository.truncate();
    //Insert new Info
    await UserRepository.insert(users);
    await SubscriptionRepository.insert(subscriptions);
    await CourseRepository.insert(courses);
    await ShiftRepository.insert(shifts);
    //Reset old Ip
    ApiService.getInstance().setIP(oldIp);
  }
}
