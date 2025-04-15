import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class AuthRepository {
  static Future<String> signup(Account account) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/auth";
    Map<String, dynamic> requestBody = account.toJson();
    requestBody['gymId'] = ApiService.getInstance().getGymId();
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

  static Future<List<Account>> gyms() async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/auth/gyms";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<dynamic> accountsData = response.data["body"];
      return accountsData.map((json) => Account.fromJson(json)).toList();
    } else {
      throw response.data;
    }
  }

  static Future delete({required String gymId, required String email}) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/auth?email=$email&gymId=$gymId";
    Response response = await ApiService.getInstance().dio.delete(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
