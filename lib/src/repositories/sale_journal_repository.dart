import 'package:gym_manager_core/core.dart';

class SaleJournalRepository {
  static Future<SaleJournal> get(int saleId) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal/$saleId";
    final response = await ApiService.getInstance().dio.get(url);
    return SaleJournal.fromJson(response.data);
  }

  /// Aggiunge un'azione al journal della vendita: il journal nasce con la prima
  static Future<SaleJournal> insert(SaleAction action) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal";
    final response =
        await ApiService.getInstance().dio.post(url, data: action.toJson());
    return SaleJournal.fromJson(response.data);
  }
}
