import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ApiService {
  String _IP = "127.0.0.1";
  int _PORT = 3000;
  String? _gymId;

  String? _email;
  String? _password;

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

  void setGymId(String id) {
    _gymId = id;
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

  void setPassword(String? password) {
    _password = password;
  }

  String? getEmail() {
    return _email;
  }

  String? getPassword() {
    return _password;
  }

  String? getGymId() {
    return _gymId;
  }

  String getIP() {
    return _IP;
  }

  int getPORT() {
    return _PORT;
  }
}
