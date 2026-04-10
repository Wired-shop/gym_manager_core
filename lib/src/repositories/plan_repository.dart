import 'package:gym_manager_core/core.dart';

class PlanRepository {
  static Future<Plan?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/Plans/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Plan.fromJson(response.data) : null;
  }

  static Future<List<Plan>> list(int courseId) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/Plans?courseId=$courseId";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Plan.fromJson(e)).toList();
  }

  static Future<Plan> insert(Plan plan) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/Plans";
    final response =
        await ApiService.getInstance().dio.post(url, data: plan.toJson());
    return Plan.fromJson(response.data);
  }

  static Future<Plan> update(Plan plan) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/Plans/";
    await ApiService.getInstance().dio.put(url, data: plan.toJson());
    return plan;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/Plans/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
