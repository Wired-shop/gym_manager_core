import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ShiftRepository {
  static Stream<List<Shift>> stream({int? courseId}) {
    String wsUrl =
        'ws://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/stream/shifts?courseId=$courseId';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Shift.fromJson(e))
          .toList();
    });
  }

  static Future<List<Shift>> list({int? courseId}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/shifts?courseId=$courseId';
    Response response = await ApiService.getInstance().dio.get(
          url,
        );
    if (response.data["responseType"] == "ok") {
      List<Shift> shifts = (response.data["body"] as List<dynamic>)
          .map((e) => Shift.fromJson(e))
          .toList();
      return shifts;
    } else {
      throw response.data;
    }
  }

  static Future<Shift> insert({required Shift shift}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/shifts';
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: shift.toJson(),
        );
    if (response.data["responseType"] == "ok") {
      Shift newShift = Shift.fromJson(response.data["body"]);
      return newShift;
    } else {
      throw response.data;
    }
  }

  static Future<Shift> update({required Shift shift}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/shifts';
    Response response = await ApiService.getInstance().dio.put(
          url,
          data: shift.toJson(),
        );
    if (response.data["responseType"] == "ok") {
      Shift updatedShift = Shift.fromJson(response.data["body"]);
      return updatedShift;
    } else {
      throw response.data;
    }
  }

  static Future<Shift?> get({required int id}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/shifts/$id';
    Response response = await ApiService.getInstance().dio.get(
          url,
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Shift shift = Shift.fromJson(response.data["body"]);
      return shift;
    } else {
      return null;
    }
  }

  static Future delete({required int id}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/shifts/$id';
    Response response = await ApiService.getInstance().dio.delete(
          url,
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
