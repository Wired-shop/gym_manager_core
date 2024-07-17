import 'package:dio/dio.dart';

class ApiService {
  String _databaseIp = "http://127.0.0.1";
  int _databasePort = 3000;

  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService getIstance() {
    return _instance;
  }

  Future<bool> test() async {
    Dio dio = Dio();
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_users";
    Response response = await dio.get(url);
    if (response.data["responseType"] == "ok") {
      return true;
    } else {
      return false;
    }
  }

  void setIp(String ip) {
    _databaseIp = ip;
  }

  void setPort(int port) {
    _databasePort = port;
  }

  String getIp() {
    return _databaseIp;
  }

  int getPort() {
    return _databasePort;
  }
}
