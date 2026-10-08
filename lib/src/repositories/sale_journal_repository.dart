import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class SaleJournalRepository {
  static Future<SaleJournal?> get(int saleId) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal/$saleId";
    try {
      final response = await ApiService.getInstance().dio.get(url);
      return response.data != null ? SaleJournal.fromJson(response.data) : null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  static Future<SaleJournal> create(SaleJournal journal) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal";
    final response =
        await ApiService.getInstance().dio.post(url, data: journal.toJson());
    return SaleJournal.fromJson(response.data);
  }

  static Future<SaleJournal> addAction(SaleAction action) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal/action";
    final response =
        await ApiService.getInstance().dio.post(url, data: action.toJson());
    return SaleJournal.fromJson(response.data);
  }
}
