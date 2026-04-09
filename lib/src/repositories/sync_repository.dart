import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SyncRepository {
  static Future<Map<String, dynamic>> sync({
    required String gymId,
    required String supabaseUrl,
    required String supabaseKey,
  }) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sync";

    Response response = await ApiService.getInstance().dio.post(url, data: {
      'gymId': gymId,
      'supabaseUrl': supabaseUrl,
      'supabaseKey': supabaseKey,
    });

    if (response.data["responseType"] == "ok") {
      return response.data["body"] as Map<String, dynamic>;
    } else {
      throw response.data;
    }
  }
}
