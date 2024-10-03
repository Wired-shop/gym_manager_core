import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import '../models/entry.dart';
import '../services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EntryRepository {
  static Future<Entry> insert({required Entry entry}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/entries/";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: entry.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/entries?date=${dateTime?.toIso8601String()}&userId=$userId";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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

  static Stream<List<Entry>> stream({DateTime? dateTime}) {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}';
    String wsUrl =
        'ws://localhost:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/courses/entries/entries/stream?date=${dateTime?.toIso8601String()}';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      headers: {
        'Authorization': basicAuth,
      },
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Entry.fromJson(e))
          .toList();
    });
  }
}
