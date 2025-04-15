import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class BookingRepository {
  static Future<List<Booking>> list({
    int? shiftId,
    int? courseId,
    int? userId,
    DateTime? date,
    BookingStatus? status,
    String? IP,
  }) async {
    IP = IP ?? ApiService.getInstance().getIP();
    String url =
        'https://$IP:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookings?courseId=$courseId&shiftId=$shiftId&userId=$userId&status=${status?.name}&date=${date?.toIso8601String()}';
    Response response = await ApiService.getInstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      List<Booking> bookings = (response.data["body"] as List<dynamic>)
          .map((e) => Booking.fromJson(e))
          .toList();
      return bookings;
    } else {
      throw response.data;
    }
  }

  static Future<Booking> insert(Booking booking) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookings';
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: booking.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      Booking newBooking = Booking.fromJson(response.data["body"]);
      return newBooking;
    } else {
      throw response.data;
    }
  }

  static Future<Booking> update(Booking booking) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookings/";
    Response response = await ApiService.getInstance().dio.put(
          url,
          data: booking.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getInstance().getEmail()}:${ApiService.getInstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      Booking updatedBooking = Booking.fromJson(response.data["body"]);
      return updatedBooking;
    } else {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/gyms/${ApiService.getInstance().getGymId()}/bookings/$id';
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
