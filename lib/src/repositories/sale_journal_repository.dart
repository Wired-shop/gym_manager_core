import 'package:gym_manager_core/core.dart';

class SaleJournalRepository {
  static String _url(int saleId) =>
      "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$saleId/journal";

  static Future<SaleJournal> get(int saleId) async {
    final response = await ApiService.getInstance().dio.get(_url(saleId));
    return SaleJournal.fromJson(response.data);
  }

  /// Aggiunge un'azione: il journal nasce con la prima
  static Future<SaleJournal> addAction(SaleAction action) async {
    final response = await ApiService.getInstance()
        .dio
        .post(_url(action.saleId), data: action.toJson());
    return SaleJournal.fromJson(response.data);
  }
}
