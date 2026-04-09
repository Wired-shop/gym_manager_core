import 'dart:io';
import 'dart:convert';
import 'package:gym_manager_core/core.dart';
import 'package:web_socket_channel/io.dart';

class SaleRepository {
  static Stream<List<Sale>> stream() {
    final wsUrl =
        'wss://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/stream/sales';
    final channel = IOWebSocketChannel.connect(
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
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales";
    final response =
        await ApiService.getInstance().dio.post(url, data: sale.toJson());
    return Sale.fromJson(response.data);
  }

  static Future<Sale> update(Sale sale) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/${sale.id}";
    final response =
        await ApiService.getInstance().dio.put(url, data: sale.toJson());
    return Sale.fromJson(response.data);
  }

  static Future<List<Sale>> list(
      {String? q,
      bool? completed,
      DateTime? startDate,
      DateTime? endDate}) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales?q=$q&completed=$completed&startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Sale.fromJson(e)).toList();
  }

  static Future<Sale?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Sale.fromJson(response.data) : null;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
