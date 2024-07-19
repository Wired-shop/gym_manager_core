import 'dart:convert';

import '../enums/validation_response.dart';
import '../enums/validation_response_warnings.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  static final Dio _dio = Dio();

  static Stream<List<User>> stream(
      {String? q,
      ValidationResponse? validationResponse,
      ValidationResponseWarnings? validationResponseWarnings}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/list_users_stream?&q=$q&validationResponse=${validationResponse?.name}&validationResponseWarnings=${validationResponseWarnings?.name}'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => User.fromJson(e))
          .toList();
    });
  }

  static Future<List<User>> list(
      {ValidationResponse? validationResponse}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_users?validationResponse=${validationResponse?.name}";
    Response response = await _dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<User> users = (response.data["body"] as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList();
      return users;
    } else {
      throw response.data;
    }
  }

  static Future insert(User user) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/insert_user";
    Response response = await _dio.post(url, data: user.toJson());
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future edit(User user) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/update_user";
    Response response = await _dio.put(url, data: user.toJson());
    if (response.data["responseType"] == "ok") {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      throw response.data;
    }
  }

  static Future<User?> get({int? id}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/get_user?id=$id";
    Response response = await _dio.get(url);
    if (response.data["responseType"] == "ok") {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/delete_user?id=$id";
    Response response = await _dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
