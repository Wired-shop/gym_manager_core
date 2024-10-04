import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class SyncRepository {
  static Future<Map<String, dynamic>> sync(String remoteIP) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/sync/$remoteIP";
    Response response = await ApiService.getIstance().dio.post(
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
