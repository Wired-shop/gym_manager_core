import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class BookableShiftRepository {
  static Future<List<BookableShift>> list(
      {int? shiftId, int? courseId, DateTime? date, String? IP}) async {
    IP = IP ?? ApiService.getInstance().getIP();
    String url =
        'https://$IP:${ApiService.getInstance().getPORT()}/bookableShifts?shiftId=$shiftId&courseId=$courseId&date=${date?.toIso8601String()}';
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<BookableShift> bookableShifts =
          (response.data["body"] as List<dynamic>)
              .map((e) => BookableShift.fromJson(e))
              .toList();
      return bookableShifts;
    } else {
      throw response.data;
    }
  }

  static Future<List<BookableShift>> insert(List<BookableShift> shifts) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/bookableShifts';
    List<Map<String, dynamic>> shiftsMapped =
        shifts.map((shift) => shift.toJson()).toList();
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: shiftsMapped,
        );
    if (response.data["responseType"] == "ok") {
      List<BookableShift> insertedShifts =
          (response.data["body"] as List<dynamic>)
              .map((e) => BookableShift.fromJson(e))
              .toList();
      return insertedShifts;
    } else {
      throw response.data;
    }
  }

  static Future generate() async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/bookableShifts/generate';
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/bookableShifts/$id';
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future<void> truncate() async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/bookableShifts/truncate";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }
}
