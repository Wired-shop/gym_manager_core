import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class SyncRepository {
  static Future<Map<String, dynamic>> sync(
      {required String IP, required int PORT}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/sync?ip=$IP&port=$PORT";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      return response.data;
    } else {
      throw response.data;
    }
  }
}
