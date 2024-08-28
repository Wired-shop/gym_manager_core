import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class ShiftRepository {
  static Stream<List<Shift>> stream({int? courseId}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/list_shifts_stream?courseId=$courseId'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Shift.fromJson(e))
          .toList();
    });
  }

  static Future<List<Shift>> list({int? courseId}) async {
    String url =
        '${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_courses?courseId=$courseId';
    Response response = await ApiService.getIstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<Shift> shifts = (response.data["body"] as List<dynamic>)
          .map((e) => Shift.fromJson(e))
          .toList();
      return shifts;
    } else {
      throw response.data;
    }
  }

  static Future insert(Shift shift) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/insert_shift";
    Response response =
        await ApiService.getIstance().dio.post(url, data: shift.toJson());
    if (response.data["responseType"] == "ok") {
      Shift shift = Shift.fromJson(response.data["body"]);
      return shift;
    } else {
      throw response.data;
    }
  }

  static Future update(Shift shift) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/update_shift";
    Response response =
        await ApiService.getIstance().dio.post(url, data: shift.toJson());
    if (response.data["responseType"] == "ok") {
      Shift course = Shift.fromJson(response.data["body"]);
      return course;
    } else {
      throw response.data;
    }
  }

  static Future<Shift?> get({int? id}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/get_shift?id=$id";
    Response response = await ApiService.getIstance().dio.get(url);
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Shift shift = Shift.fromJson(response.data["body"]);
      return shift;
    } else {
      return null;
    }
  }

  static Future delete(int id) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/delete_shift?id=$id";
    Response response = await ApiService.getIstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
