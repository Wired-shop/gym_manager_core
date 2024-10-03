import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class ShiftRepository {
  static Stream<List<Shift>> stream() {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/shifts/stream'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Shift.fromJson(e))
          .toList();
    });
  }

  static Future<List<Shift>> list() async {
    String url =
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/shifts';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
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
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/shifts';
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: shift.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
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
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/shifts';
    Response response = await ApiService.getIstance().dio.put(
          url,
          data: shift.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
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
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/shifts/$id';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
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
        'http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/shifts/$id';
    Response response = await ApiService.getIstance().dio.delete(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
