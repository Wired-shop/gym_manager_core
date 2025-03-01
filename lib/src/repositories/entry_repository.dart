import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import '../models/entry.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EntryRepository {
  static Future<Entry> insert({required Entry entry}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/entries/";
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: entry.toJson(),
        );
    if (response.data["responseType"] == "ok") {
      Entry newEntry = Entry.fromJson(response.data["body"]);
      return newEntry;
    } else {
      throw response.data;
    }
  }

  static Future<List<Entry>> list(
      {DateTime? startDate, DateTime? endDate, int? userId}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/entries?startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}&userId=$userId";
    Response response = await ApiService.getInstance().dio.get(
          url,
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

  static Stream<List<Entry>> stream({DateTime? startDate, DateTime? endDate}) {
    String wsUrl =
        'ws://localhost:${ApiService.getInstance().getPORT()}/stream/entries?startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Entry.fromJson(e))
          .toList();
    });
  }
}
