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

  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService getInstance() {
    return _instance;
  }

  void setIP(String IP) {
    _IP = IP;
  }

  void setPORT(int PORT) {
    _PORT = PORT;
  }

  void setEmail(String? email) {
    _email = email;
  }

  String? getEmail() {
    return _email;
  }

  String getIP() {
    return _IP;
  }

  int getPORT() {
    return _PORT;
  }
}
