import 'package:gym_manager_core/core.dart';

class SaleJournalRepository {
  static Future<SaleJournal> get(int saleId) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$saleId/journal";
    final response = await ApiService.getInstance().dio.get(url);
    return SaleJournal.fromJson(response.data);
  }

  /// Utente e data li assegna il server: si inviano solo tipo e rata
  static Future<SaleJournal> insert(
      int saleId, List<SaleAction> actions) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/sales/$saleId/journal";
    final response = await ApiService.getInstance().dio.post(url, data: {
      'actions': actions
          .map((a) => {
                'type': a.type.name,
                'installmentNumber': a.installmentNumber,
              })
          .toList(),
    });
    return SaleJournal.fromJson(response.data);
  }
}
