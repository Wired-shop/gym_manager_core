import 'package:gym_manager_core/core.dart';

class CampaignRepository {
  static Future<Campaign> insert(Campaign campaign) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/campaigns";
    final response =
        await ApiService.getInstance().dio.post(url, data: campaign.toJson());
    return Campaign.fromJson(response.data);
  }

  static Future<Campaign> update(Campaign campaign) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/campaigns/${campaign.id}";
    final response =
        await ApiService.getInstance().dio.put(url, data: campaign.toJson());
    return Campaign.fromJson(response.data);
  }

  static Future<List<Campaign>> list({
    String? q,
    String? status,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/campaigns?q=$q&status=$status&type=$type&startDate=${startDate?.toIso8601String()}&endDate=${endDate?.toIso8601String()}";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Campaign.fromJson(e)).toList();
  }

  static Future<Campaign?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/campaigns/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Campaign.fromJson(response.data) : null;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/campaigns/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
