import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import '../models/entry.dart';
import '../services/api_service.dart';

class EntryRepository {
  static Future<Entry> insert(Entry entry) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/entries/";
    final response =
        await ApiService.getInstance().dio.post(url, data: entry.toJson());
    return Entry.fromJson(response.data);
  }

  static Future<List<Entry>> list(
      {DateTime? startDate, DateTime? endDate, int? userId, int? limit}) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/entries?startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}&userId=$userId&limit=$limit";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Entry.fromJson(e)).toList();
  }

  static Future<List<Entry>> listToday({int? userId}) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/entries/today?userId=$userId";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Entry.fromJson(e)).toList();
  }

  static Stream<List<Entry>> stream({DateTime? startDate, DateTime? endDate}) {
    final wsUrl =
        "wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/entries?startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}";
    final channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      customClient: HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true,
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Entry.fromJson(e))
          .toList();
    });
  }
}
