import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/entry.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EntryRepository {
<<<<<<< HEAD
  static final Dio _dio = Dio();

=======
>>>>>>> 4a894ca (Aggiunto supporto ai corsi)
  static Future insert(Entry entry) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/insert_entry";
    Response response =
        await ApiService.getIstance().dio.post(url, data: entry.toJson());
    if (response.data["responseType"] == "ok") {
      Entry entry = Entry.fromJson(response.data["body"]);
      return entry;
    } else {
      throw response.data;
    }
  }

  static Future<List<Entry>> list({DateTime? dateTime, int? userId}) async {
    String url =
        '${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_entries?date=${dateTime?.toIso8601String()}&userId=$userId';
    Response response = await _dio.get(url);
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
          'ws://localhost:${ApiService.getIstance().getPort()}/list_entries_stream?date=${dateTime?.toIso8601String()}&userId=$userId'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Entry.fromJson(e))
          .toList();
    });
  }
}
