import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class SyncRepository {
  static Future<Map<String, dynamic>> sync(
      {required String IP, required int PORT}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/sync?ip=$IP&port=$PORT";
    Response response = await ApiService.getInstance().dio.get(
          url,
        );
    if (response.data["responseType"] == "ok") {
      return response.data;
    } else {
      throw response.data;
    }
  }
}
