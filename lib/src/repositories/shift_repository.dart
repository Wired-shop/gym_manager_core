import 'package:gym_manager_core/core.dart';

class ShiftRepository {
  static Future<void> truncate() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts/truncate";
    await ApiService.getInstance().dio.get(url);
  }

  static Future<List<Shift>> list({int? courseId, bool? publishable}) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts?courseId=$courseId&publishable=$publishable";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Shift.fromJson(e)).toList();
  }

  static Future<List<Shift>> insert(List<Shift> shifts) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts";
    final response = await ApiService.getInstance()
        .dio
        .post(url, data: shifts.map((e) => e.toJson()).toList());
    return (response.data as List).map((e) => Shift.fromJson(e)).toList();
  }

  static Future<Shift> update(Shift shift) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts";
    final response =
        await ApiService.getInstance().dio.put(url, data: shift.toJson());
    return Shift.fromJson(response.data);
  }

  static Future<Shift?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Shift.fromJson(response.data) : null;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
