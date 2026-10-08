import 'package:gym_manager_core/core.dart';

class SaleJournalRepository {
  static Future<SaleJournal> get(int saleId) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal";
    final response = await ApiService.getInstance().dio.get(url);
    return SaleJournal.fromJson(response.data);
  }

  static Future<SaleJournal> insert(
      {required SaleJournal journal, required SaleAction action}) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/saleJournal";
    final response = await ApiService.getInstance().dio.post(url, data: {
      'journal': journal.toJson(),
      'action': action.toJson(),
    });
    return SaleJournal.fromJson(response.data);
  }
}
