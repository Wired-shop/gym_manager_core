import 'package:gym_manager_core/core.dart';

class SyncUtils {
  static Future syncTo({
    required String ip,
    required List<User> users,
    required List<Subscription> subscriptions,
    required List<Course> courses,
    required List<Shift> shifts,
    required List<BookableShift> bookableShifts,
    bool includeUsers = true,
    bool includeSubscriptions = true,
    bool includeCourses = true,
    bool includeShifts = true,
    bool includeBookableShifts = true,
  }) async {
    String oldIp = ApiService.getInstance().getIP();
    ApiService.getInstance().setIP(ip);
    includeUsers == false ? null : await UserRepository.truncate();
    includeSubscriptions == false
        ? null
        : await SubscriptionRepository.truncate();
    includeCourses == false ? null : await CourseRepository.truncate();
    includeShifts == false ? null : await ShiftRepository.truncate();
    includeBookableShifts == false
        ? null
        : await BookableShiftRepository.truncate();
    includeUsers == false ? null : await UserRepository.insert(users);
    includeSubscriptions == false
        ? null
        : await SubscriptionRepository.insert(subscriptions);
    includeCourses == false ? null : await CourseRepository.insert(courses);
    includeShifts == false ? null : await ShiftRepository.insert(shifts);
    includeBookableShifts == false
        ? null
        : await BookableShiftRepository.insert(bookableShifts);

    ApiService.getInstance().setIP(oldIp);
  }
}
