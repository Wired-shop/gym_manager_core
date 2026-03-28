import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class AuthRepository {
  static Future<String> create(Account account) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/auth";
    Map<String, dynamic> requestBody = account.toJson();
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: requestBody,
        );

    if (response.data["responseType"] == "ok") {
      return response.data["body"];
    } else {
      throw response.data;
    }
  }
}
