import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class CourseRepository {
  static Stream<List<Course>> stream() {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/list_courses_stream'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Course.fromJson(e))
          .toList();
    });
  }

  static Future insert(Course course) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/insert_course";
    Response response =
        await ApiService.getIstance().dio.post(url, data: course.toJson());
    if (response.data["responseType"] == "ok") {
      Course course = Course.fromJson(response.data["body"]);
      return course;
    } else {
      throw response.data;
    }
  }

  static Future<List<Course>> list() async {
    String url =
        '${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_courses';
    Response response = await ApiService.getIstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<Course> courses = (response.data["body"] as List<dynamic>)
          .map((e) => Course.fromJson(e))
          .toList();
      return courses;
    } else {
      throw response.data;
    }
  }

  static Future update(Course course) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/update_course";
    Response response =
        await ApiService.getIstance().dio.post(url, data: course.toJson());
    if (response.data["responseType"] == "ok") {
      Course course = Course.fromJson(response.data["body"]);
      return course;
    } else {
      throw response.data;
    }
  }

  static Future<Course?> get({int? id}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/get_course?id=$id";
    Response response = await ApiService.getIstance().dio.get(url);
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Course course = Course.fromJson(response.data["body"]);
      return course;
    } else {
      return null;
    }
  }

  static Future delete(int id) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/delete_course?id=$id";
    Response response = await ApiService.getIstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
