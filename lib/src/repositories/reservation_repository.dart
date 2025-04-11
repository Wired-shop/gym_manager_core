import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class ReservationRepository {
  static Future<List<Reservation>> list(
      {int? courseId, int? userId, DateTime? dateTime}) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/reservations?courseId=$courseId&userId=$userId&dateTime=${dateTime?.toIso8601String()}}';
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      List<Reservation> reservations = (response.data["body"] as List<dynamic>)
          .map((e) => Reservation.fromJson(e))
          .toList();
      return reservations;
    } else {
      throw response.data;
    }
  }

  static Future<Reservation> insert(Reservation reservation) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/reservations';
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: reservation.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      Reservation newReservation = Reservation.fromJson(response.data["body"]);
      return newReservation;
    } else {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        'http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/reservations/$id';
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
}
