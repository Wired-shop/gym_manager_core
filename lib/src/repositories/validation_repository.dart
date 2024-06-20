import 'package:dio/dio.dart';
import '../models/validation_result.dart';
import '../services/api_service.dart';

class ValidationRepository {
  static final _dio = Dio();

  static Future<ValidationResult> validate(int userId) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/validation?userId=$userId";
    Response response = await _dio.get(url);
    if (response.data["responseType"] == "ok") {
      ValidationResult user = ValidationResult.fromJson(response.data["body"]);
      return user;
    } else {
      throw response.data;
    }
  }
}
