import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'dart:convert';

class ShiftRepository {
  static Future<void> truncate() async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts/truncate";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }

  static Future<List<Shift>> list({
    int? courseId,
    bool? publishable,
  }) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts?courseId=$courseId&publishable=$publishable';
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<Shift> shifts = (response.data["body"] as List<dynamic>)
          .map((e) => Shift.fromJson(e))
          .toList();
      return shifts;
    } else {
      throw response.data;
    }
  }

  static Future<List<Shift>> insert(List<Shift> shifts) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts';
    List<Map<String, dynamic>> shiftsMapped =
        shifts.map((shift) => shift.toJson()).toList();
    Response response =
        await ApiService.getInstance().dio.post(url, data: shiftsMapped);
    if (response.data["responseType"] == "ok") {
      List<Shift> insertedShifts = (response.data["body"] as List<dynamic>)
          .map((e) => Shift.fromJson(e))
          .toList();
      return insertedShifts;
    } else {
      throw response.data;
    }
  }

  static Future<Shift> update(Shift shift) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts';
    Response response =
        await ApiService.getInstance().dio.put(url, data: shift.toJson());
    if (response.data["responseType"] == "ok") {
      Shift updatedShift = Shift.fromJson(response.data["body"]);
      return updatedShift;
    } else {
      throw response.data;
    }
  }

  static Future<Shift?> get(int id) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts/$id';
    Response response = await ApiService.getInstance().dio.get(url);
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
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/shifts/$id';
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
