import 'dart:convert';
import 'dart:io';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';

class UserRepository {
  static Future<void> truncate() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/truncate";
    await ApiService.getInstance().dio.get(url);
  }

  static Stream<List<User>> stream({String? q, UsersFilter? filter}) {
    final wsUrl =
        'wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/users?q=$q&${filter?.toQueryParameters()}';
    final channel = IOWebSocketChannel.connect(
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
    if (filter != null) url += "&${filter.toQueryParameters()}";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }

  static Future<List<User>> insert(List<User> users) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users";
    final response = await ApiService.getInstance()
        .dio
        .post(url, data: users.map((e) => e.toJson()).toList());
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }

  static Future<User> update(User user) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users";
    final response =
        await ApiService.getInstance().dio.put(url, data: user.toJson());
    return User.fromJson(response.data);
  }

  static Future<User?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? User.fromJson(response.data) : null;
  }

  static Future<User?> getUserByEmail(String email) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/emails/$email";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? User.fromJson(response.data) : null;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/users/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
