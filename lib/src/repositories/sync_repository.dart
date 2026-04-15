import '../services/api_service.dart';

class SyncRepository {
  static Future<void> init({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sync/init";
    await ApiService.getInstance().dio.post(
      url,
      data: {
        'supabaseUrl': supabaseUrl,
        'supabaseAnonKey': supabaseAnonKey,
      },
    );
  }

  static Future<void> sync({
    required String gymId,
    required String email,
    required String password,
  }) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sync";
    await ApiService.getInstance().dio.post(
      url,
      data: {
        'gymId': gymId,
        'email': email,
        'password': password,
      },
    );
  }
}
