import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  static Stream<List<User>> stream({String? q, UsersFilter? filter}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/users/stream?q=$q&${filter?.toQueryParameters()}'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => User.fromJson(e))
          .toList();
    });
  }

  static Future<List<User>> list({String? q, UsersFilter? filter}) async {
    String url =
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/users?q=$q&${filter?.toQueryParameters()}';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      List<User> users = (response.data["body"] as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList();
      return users;
    } else {
      throw response.data;
    }
  }

  static Future insert({required User user}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/users";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: user.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      User newUser = User.fromJson(response.data["body"]);
      return newUser;
    } else {
      throw response.data;
    }
  }

  static Future update({required int id, required User user}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/users/$id";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: user.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      User updatedUser = User.fromJson(response.data["body"]);
      return updatedUser;
    } else {
      throw response.data;
    }
  }

  static Future<User?> get({required int id}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/users/$id";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      return null;
    }
  }

  static Future delete({required int id}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/users/$id";
    Response response = await ApiService.getIstance().dio.delete(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
