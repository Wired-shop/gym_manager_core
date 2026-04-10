import '../services/api_service.dart';

class SyncRepository {
  static Future<Map<String, dynamic>> sync({
    required String gymId,
    required String email,
    required String password,
  }) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sync";

    final response = await ApiService.getInstance().dio.post(
      url,
      data: {
        'gymId': gymId,
        'email': email,
        'password': password,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }
}
