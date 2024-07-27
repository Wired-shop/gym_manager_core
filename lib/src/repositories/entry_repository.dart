import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/entry.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EntryRepository {
  static final Dio _dio = Dio();

  static Future<Entry> insert(Entry entry) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/entries";
    Response response = await _dio.post(url, data: entry.toJson());
    if (response.data["responseType"] == "ok") {
      return Entry.fromJson(response.data["body"]);
    } else {
      throw response.data;
    }
  }

  static Stream<List<Entry>> stream({DateTime? dateTime}) {
    return WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost:${ApiService.getIstance().getPort()}/entries/stream?date=${dateTime?.toIso8601String()}'),
    ).stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Entry.fromJson(e))
          .toList();
    });
  }
}
