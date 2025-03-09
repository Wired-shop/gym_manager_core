import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class AuthRepository {
  static Future<String> signup(Account account) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/auth/signup";
    print(url);

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
