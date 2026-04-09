import 'dart:io';
import 'dart:convert';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';

class CourseRepository {
  static Stream<List<Course>> stream() {
    final wsUrl =
        "wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/courses";
    final channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      customClient: HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true,
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Course.fromJson(e))
          .toList();
    });
  }

  static Future<void> truncate() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/truncate";
    await ApiService.getInstance().dio.get(url);
  }

  static Future<List<Course>> insert(List<Course> courses) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses";
    final response = await ApiService.getInstance()
        .dio
        .post(url, data: courses.map((e) => e.toJson()).toList());
    return (response.data as List).map((e) => Course.fromJson(e)).toList();
  }

  static Future<List<Course>> list() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Course.fromJson(e)).toList();
  }

  static Future<Course> update(Course course) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/";
    final response =
        await ApiService.getInstance().dio.put(url, data: course.toJson());
    return Course.fromJson(response.data);
  }

  static Future<Course?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Course.fromJson(response.data) : null;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
