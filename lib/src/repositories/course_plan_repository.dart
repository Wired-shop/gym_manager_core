import 'package:gym_manager_core/core.dart';

class CoursePlanRepository {
  static Future<CoursePlan?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? CoursePlan.fromJson(response.data) : null;
  }

  static Future<List<CoursePlan>> list(int courseId) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans?courseId=$courseId";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => CoursePlan.fromJson(e)).toList();
  }

  static Future<CoursePlan> insert(CoursePlan coursePlan) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans";
    final response =
        await ApiService.getInstance().dio.post(url, data: coursePlan.toJson());
    return CoursePlan.fromJson(response.data);
  }

  static Future<CoursePlan> update(CoursePlan coursePlan) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans/";
    final response =
        await ApiService.getInstance().dio.put(url, data: coursePlan.toJson());
    return CoursePlan.fromJson(response.data);
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
