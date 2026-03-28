import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class SaleRepository {
  static Stream<List<Sale>> stream() {
    String wsUrl =
        'wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/sales';
    WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse(wsUrl),
      customClient: HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true,
    );
    return channel.stream.asyncMap((response) {
      return List<Map<String, dynamic>>.from(json.decode(response.toString()))
          .map((e) => Sale.fromJson(e))
          .toList();
    });
  }

  static Future<Sale> insert(Sale sale) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales";
    Response response =
        await ApiService.getInstance().dio.post(url, data: sale.toJson());
    if (response.data["responseType"] == "ok") {
      Sale insertedSale = Sale.fromJson(response.data["body"]);
      return insertedSale;
    } else {
      throw response.data;
    }
  }

  static Future<Sale> update(Sale sale) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/${sale.id}";
    Response response =
        await ApiService.getInstance().dio.put(url, data: sale.toJson());
    if (response.data["responseType"] == "ok") {
      return Sale.fromJson(response.data["body"]);
    } else {
      throw response.data;
    }
  }

  static Future<List<Sale>> list({
    String? q,
    bool? completed,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales?q=$q&completed=$completed&startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}';

    Response response = await ApiService.getInstance().dio.get(url);

    if (response.data["responseType"] == "ok") {
      List<Sale> sales = (response.data["body"] as List<dynamic>)
          .map((e) => Sale.fromJson(e))
          .toList();
      return sales;
    } else {
      throw response.data;
    }
  }

  static Future<Sale?> get(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$id";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Sale sale = Sale.fromJson(response.data["body"]);
      return sale;
    } else {
      return null;
    }
  }

  static Future delete(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$id";
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
