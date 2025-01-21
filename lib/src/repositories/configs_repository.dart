import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:gym_manager_core/src/models/configs.dart';

class ConfigsRepository {
  static Future<String> write({required Configs configs}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/configs";
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: configs.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      return response.data["body"];
    } else {
      throw response.data;
    }
  }

  static Future<Configs?> read() async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/configs";
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Configs configs = Configs.fromJson(response.data["body"]);
      return configs;
    } else {
      return null;
    }
  }
}
