import 'package:dio/dio.dart';

class ApiService {
  String _IP = "127.0.0.1";
  int _PORT = 3000;

  Dio dio = Dio();

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

  String getIP() {
    return _IP;
  }

  int getPORT() {
    return _PORT;
  }
}
