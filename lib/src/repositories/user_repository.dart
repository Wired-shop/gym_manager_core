import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  static final Dio _dio = Dio();

  static Stream<List<User>> stream(
      {String? q, String? badgeCode, UsersFilter? filter}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/list_users_stream?badgeCode=$badgeCode&q=$q&${filter?.toQueryParameters()}'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => User.fromJson(e))
          .toList();
    });
  }

  static Future<List<User>> list({String? q, UsersFilter? filter}) async {
    String url =
        '${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_users?q=$q&${filter?.toQueryParameters()}';
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
    if (response.data["responseType"] == "ok") {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      throw response.data;
    }
  }

  static Future update(User user) async {
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
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      return null;
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
