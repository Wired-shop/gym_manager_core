import 'dart:convert';
import 'package:gym_manager_backend/src/models/users_filter.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  static final Dio _dio = Dio();

  static Stream<List<User>> stream({String? q, UsersFilter? filter}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/users/stream?q=$q&${filter?.toQueryParams()}'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => User.fromJson(e))
          .toList();
    });
  }

  static Future<List<User>> list({String? q, UsersFilter? filter}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/users?q=$q&${filter?.toQueryParams()}";
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

  static Future<User> insert(User user) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/users";
    Response response = await _dio.post(url, data: user.toJson());
    if (response.data["responseType"] == "ok") {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      throw response.data;
    }
  }

  static Future<User> update(User user) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/users";
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
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/users/$id";
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
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/users?id=$id";
    Response response = await _dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
