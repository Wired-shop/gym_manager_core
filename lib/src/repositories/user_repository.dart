import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  static Stream<List<User>> stream({String? q, UsersFilter? filter}) {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}';
    String wsUrl =
        'ws://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/stream/users?q=$q&${filter?.toQueryParameters()}';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      headers: {
        'Authorization': basicAuth,
      },
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => User.fromJson(e))
          .toList();
    });
  }

  static Future<List<User>> list({String? q, UsersFilter? filter}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users?q=$q";

    if (filter != null) {
      url += "&${filter.toQueryParameters()}";
    }

    print(url);
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"].contains("ok")) {
      List<User> users = (response.data["body"] as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList();
      return users;
    } else {
      throw response.data;
    }
  }

  static Future import({required List<User> users}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users/import";
    List<Map<String, dynamic>> usersMapped =
        users.map((user) => user.toJson()).toList();
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: jsonEncode(usersMapped),
          options: Options(
            contentType: "application/json",
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
            },
          ),
        );
    if (response.data["responseType"] == "ok") {
      return response.data["body"];
    } else {
      throw response.data;
    }
  }

  static Future<User> insert({required User user}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users";
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: user.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      return User.fromJson(response.data["body"]);
    } else {
      throw response.data;
    }
  }

  static Future update({required User user}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users";
    Response response = await ApiService.getInstance().dio.put(
          url,
          data: user.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
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
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users/$id";
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      User user = User.fromJson(response.data["body"]);
      return user;
    } else {
      return null;
    }
  }

  static Future<User?> getUserByEmail({required String email}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users/emails/$email";
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
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
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/users/$id";
    Response response = await ApiService.getInstance().dio.delete(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getUsername()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
