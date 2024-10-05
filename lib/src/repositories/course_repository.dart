import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class CourseRepository {
  static Stream<List<Course>> stream({String? q, UsersFilter? filter}) {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}';
    String wsUrl =
        'ws://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/stream/courses';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      headers: {
        'Authorization': basicAuth,
      },
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Course.fromJson(e))
          .toList();
    });
  }

  static Future<Course> insert({required Course course}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/courses";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: course.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      Course newCourse = Course.fromJson(response.data["body"]);
      return newCourse;
    } else {
      throw response.data;
    }
  }

  static Future<List<Course>> list() async {
    String url =
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/courses';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      List<Course> courses = (response.data["body"] as List<dynamic>)
          .map((e) => Course.fromJson(e))
          .toList();
      return courses;
    } else {
      throw response.data;
    }
  }

  static Future<Course> update({required Course course}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/courses/";
    Response response = await ApiService.getIstance().dio.put(
          url,
          data: course.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      Course updatedCourse = Course.fromJson(response.data["body"]);
      return updatedCourse;
    } else {
      throw response.data;
    }
  }

  static Future<Course?> get({required int id}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/courses/$id";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Course course = Course.fromJson(response.data["body"]);
      return course;
    } else {
      return null;
    }
  }

  static Future delete({required int id}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/courses/$id";
    Response response = await ApiService.getIstance().dio.delete(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
