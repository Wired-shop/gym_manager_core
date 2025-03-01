import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:gym_manager_core/src/models/account.dart';

class AuthRepository {
  static Future<String> signUp(Account account) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/configs";
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: account.toJson(),
        );
    if (response.data["responseType"] == "ok") {
      return response.data["body"];
    } else {
      throw response.data;
    }
  }
}
