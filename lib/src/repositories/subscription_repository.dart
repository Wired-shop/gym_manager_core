import '../models/subscription.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static Future<void> truncate() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/truncate";
    await ApiService.getInstance().dio.get(url);
  }

  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions?badgeCode=$badgeCode&id=$id&userId=$userId";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Subscription.fromJson(response.data) : null;
  }

  static Future<List<Subscription>> list() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/all";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List)
        .map((e) => Subscription.fromJson(e))
        .toList();
  }

  static Future<Subscription> update(Subscription subscription) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions";
    await ApiService.getInstance().dio.put(url, data: subscription.toJson());
    return subscription;
  }

  static Future<List<Subscription>> insert(
      List<Subscription> subscriptions) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions";
    final response = await ApiService.getInstance()
        .dio
        .post(url, data: subscriptions.map((e) => e.toJson()).toList());
    return (response.data as List)
        .map((e) => Subscription.fromJson(e))
        .toList();
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
