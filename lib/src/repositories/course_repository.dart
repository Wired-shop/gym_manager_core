import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class CourseRepository {
  static Stream<List<Course>> stream() {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/courses/stream'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Course.fromJson(e))
          .toList();
    });
  }

  static Future<Course> insert({required Course course}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/courses";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: course.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      Course newCourse = Course.fromJson(response.data["body"]);
      return newCourse;
    } else {
      throw response.data;
    }
  }

  static Future<List<Course>> list({required int gymId}) async {
    String url =
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/courses';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
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
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/courses/";
    Response response = await ApiService.getIstance().dio.put(
          url,
          data: course.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
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
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/courses/$id";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
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
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/courses/$id";
    Response response = await ApiService.getIstance().dio.delete(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
