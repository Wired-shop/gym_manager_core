import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class AuthRepository {
  static Future<String> signup(Account account) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/auth/signup";
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

  static Future<List<Account>> list({String? gymId, String? email}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/auth/accounts";
    Map<String, dynamic> queryParameters = {};
    if (gymId != null) {
      queryParameters['gymId'] = gymId;
    }
    if (email != null) {
      queryParameters['email'] = email;
    }
    Response response = await ApiService.getInstance().dio.get(
          url,
          queryParameters: queryParameters,
        );
    if (response.data["responseType"] == "ok") {
      List<dynamic> accountsData = response.data["body"];
      return accountsData.map((json) => Account.fromJson(json)).toList();
    } else {
      throw response.data;
    }
  }

  static Future<List<Account>> gyms() async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/auth/gyms";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<dynamic> accountsData = response.data["body"];
      return accountsData.map((json) => Account.fromJson(json)).toList();
    } else {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/auth/accounts";
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
