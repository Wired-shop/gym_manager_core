import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class BookableShiftRepository {
  static Future<List<BookableShift>> list(
      {int? shiftId, DateTime? date}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookableShifts?shiftId=$shiftId&date=${date?.toIso8601String()}';
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
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

  static Future<List<BookableShift>> insert(List<Shift> shifts) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookableShifts';
    List<Map<String, dynamic>> shiftsMapped =
        shifts.map((shift) => shift.toJson()).toList();
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: shiftsMapped,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
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
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookableShifts/generate';
    Response response = await ApiService.getInstance().dio.delete(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookableShifts/$id';
    Response response = await ApiService.getInstance().dio.delete(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future<void> truncate() async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookableShifts/truncate";
    Response response = await ApiService.getInstance().dio.post(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }
}
