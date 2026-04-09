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
        if (response.data["responseType"] != "ok") {
          handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.data["body"].toString(),
          ));
        } else {
          response.data = response.data["body"];
          handler.next(response);
        }
      },
      onError: (error, handler) {
        final message = error.response?.data?["body"]?.toString() ??
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
