import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class CourseRepository {
  static Stream<List<Course>> stream() {
    String wsUrl =
        'wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/courses';
    WebSocketChannel channel = IOWebSocketChannel.connect(
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
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/truncate";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }

  static Future<List<Course>> insert(List<Course> courses) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses";
    List<Map<String, dynamic>> coursesMapped =
        courses.map((course) => course.toJson()).toList();
    Response response =
        await ApiService.getInstance().dio.post(url, data: coursesMapped);
    if (response.data["responseType"] == "ok") {
      List<Course> insertedCourses = (response.data["body"] as List<dynamic>)
          .map((e) => Course.fromJson(e))
          .toList();
      return insertedCourses;
    } else {
      throw response.data;
    }
  }

  static Future<List<Course>> list() async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses';
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<Course> courses = (response.data["body"] as List<dynamic>)
          .map((e) => Course.fromJson(e))
          .toList();
      return courses;
    } else {
      throw response.data;
    }
  }

  static Future<Course> update(Course course) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/";
    Response response =
        await ApiService.getInstance().dio.put(url, data: course.toJson());
    if (response.data["responseType"] == "ok") {
      Course updatedCourse = Course.fromJson(response.data["body"]);
      return updatedCourse;
    } else {
      throw response.data;
    }
  }

  static Future<Course?> get(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/$id";
    Response response = await ApiService.getInstance().dio.get(url);
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
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/courses/$id";
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
