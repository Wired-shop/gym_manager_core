import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  static Future<void> truncate() async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/truncate";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }

  static Stream<List<User>> stream({String? q, UsersFilter? filter}) {
    String wsUrl =
        'wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/users?q=$q&${filter?.toQueryParameters()}';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      customClient: HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true,
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => User.fromJson(e))
          .toList();
    });
  }

  static Future<List<User>> list({String? q, UsersFilter? filter}) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users?q=$q";
    if (filter != null) {
      url += "&${filter.toQueryParameters()}";
    }
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"].contains("ok")) {
      List<User> users = (response.data["body"] as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList();
      return users;
    } else {
      throw response.data;
    }
  }

  static Future<List<User>> insert(List<User> users) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users";
    List<Map<String, dynamic>> usersMapped =
        users.map((user) => user.toJson()).toList();
    Response response =
        await ApiService.getInstance().dio.post(url, data: usersMapped);
    if (response.data["responseType"] == "ok") {
      List<User> insertedUsers = (response.data["body"] as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList();
      return insertedUsers;
    } else {
      throw response.data;
    }
  }

  static Future update(User user) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users";
    Response response =
        await ApiService.getInstance().dio.put(url, data: user.toJson());
    if (response.data["responseType"] == "ok") {
      User updatedUser = User.fromJson(response.data["body"]);
      return updatedUser;
    } else {
      throw response.data;
    }
  }

  static Future<User?> get(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/$id";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      return null;
    }
  }

  static Future<User?> getUserByEmail(String email) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/emails/$email";
    Response response = await ApiService.getInstance().dio.get(url);
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
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/$id";
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
