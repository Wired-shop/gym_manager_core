import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/entry.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EntryRepository {
  static Future<Entry> insert({required Entry entry}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/entries/";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: entry.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      Entry newEntry = Entry.fromJson(response.data["body"]);
      return newEntry;
    } else {
      throw response.data;
    }
  }

  static Future<List<Entry>> list({DateTime? dateTime, int? userId}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/entries?date=${dateTime?.toIso8601String()}&userId=$userId";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      List<Entry> entries = (response.data["body"] as List<dynamic>)
          .map((e) => Entry.fromJson(e))
          .toList();
      return entries;
    } else {
      throw response.data;
    }
  }

  static Stream<List<Entry>> stream({DateTime? dateTime, int? userId}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/entries/stream?date=${dateTime?.toIso8601String()}&userId=$userId'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Entry.fromJson(e))
          .toList();
    });
  }
}
