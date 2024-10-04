import 'package:dio/dio.dart';

class ApiService {
  String _localIP = "127.0.0.1";
  int _localPORT = 3000;

  String _remoteIP = "85.235.151.228";
  int _remotePORT = 3000;

  String _IP = "127.0.0.1";
  int _PORT = 3000;

  String? _username;
  String? _password;

  String? _gymId;

  Dio dio = Dio();

  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService getIstance() {
    return _instance;
  }

  void switchToRemote() {
    _IP = _remoteIP;
    _PORT = _remotePORT;
  }

  void switchToLocal() {
    _IP = _localIP;
    _PORT = _localPORT;
  }

  void setGymId(String id) {
    _gymId = id;
  }

  void setLocalIP(String ip) {
    _localIP = ip;
  }

  void setLocalPORT(int port) {
    _localPORT = port;
  }

  void setRemoteIP(String ip) {
    _remoteIP = ip;
  }

  void setRemotePORT(int port) {
    _remotePORT = port;
  }

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? getUsername() {
    return _username;
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

  String getLocalIP() {
    return _localIP;
  }

  int getLocalPORT() {
    return _localPORT;
  }

  String getRemoteIP() {
    return _remoteIP;
  }

  int getRemotePORT() {
    return _remotePORT;
  }
}
