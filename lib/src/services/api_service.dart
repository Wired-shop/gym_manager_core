import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  String _databaseIp = "127.0.0.1";
  int _databasePort = 3000;
  String? _username;
  String? _password;
  int? _gymId;

  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService getIstance() {
    return _instance;
  }

  Dio dio = Dio();

  void setIp(String ip) {
    _databaseIp = ip;
  }

  void setPort(int port) {
    _databasePort = port;
  }

  void setAuthCredentials(String username, String password) {
    _username = username;
    _password = password;
  }

  void setGymId(int id) {
    _gymId = id;
  }

  Options getAuthCredentials() {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_username:$_password'))}';
    return Options(headers: {'Authorization': basicAuth});
  }

  int? getGymId() {
    return _gymId;
  }

  String getIp() {
    return _databaseIp;
  }

  int getPort() {
    return _databasePort;
  }
}
