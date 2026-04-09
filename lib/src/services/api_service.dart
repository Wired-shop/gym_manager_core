import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ApiService {
  String _IP = "127.0.0.1";
  int _PORT = 3000;

  String? _email;

  Dio dio = Dio(BaseOptions())
    ..httpClientAdapter = IOHttpClientAdapter(onHttpClientCreate: (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    });

  ApiService._privateConstructor() {
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        final data = response.data;
        if (data is! Map || data["responseType"] != "ok") {
          handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: data is Map ? data["body"]?.toString() : data.toString(),
          ));
        } else {
          response.data = data["body"];
          handler.next(response);
        }
      },
      onError: (error, handler) {
        final data = error.response?.data;
        final message = (data is Map ? data["body"]?.toString() : null) ??
            error.message ??
            "Errore sconosciuto";
        handler.reject(DioException(
          requestOptions: error.requestOptions,
          message: message,
        ));
      },
    ));
  }

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService getInstance() => _instance;

  void setIP(String IP) => _IP = IP;
  void setPORT(int PORT) => _PORT = PORT;
  void setEmail(String? email) => _email = email;

  String? getEmail() => _email;
  String getIP() => _IP;
  int getPORT() => _PORT;
}
