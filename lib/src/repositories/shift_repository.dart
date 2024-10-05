import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'dart:convert';

class ShiftRepository {
  static Future<List<Shift>> list({int? courseId}) async {
    String url =
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/shifts?courseId=$courseId';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/shifts';
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: shift.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/shifts';
    Response response = await ApiService.getIstance().dio.put(
          url,
          data: shift.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/shifts/$id';
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/shifts/$id';
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
