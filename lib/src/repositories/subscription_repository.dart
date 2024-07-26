import '../models/subscription.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static final Dio _dio = Dio();

  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/get_subscription?badgeCode=$badgeCode&id=$id&userId=$userId";
    Response response = await _dio.get(url);
    if (response.data["responseType"] == "ok") {
      Subscription subscription = Subscription.fromJson(response.data["body"]);
      return subscription;
    } else {
      throw response.data;
    }
  }

  static Future<List<Subscription>> list() async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/list_subscriptions";
    Response response = await _dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<Subscription> subscriptions =
          (response.data["body"] as List<dynamic>)
              .map((e) => Subscription.fromJson(e))
              .toList();
      return subscriptions;
    } else {
      throw response.data;
    }
  }

  static Future update(Subscription subscription) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/update_subscription";
    var response = await _dio.put(url, data: subscription.toJson());
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future insert(Subscription subscription) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/insert_subscription";
    Response response = await _dio.post(url, data: subscription.toJson());
    if (response.data["responseType"] == "ok") {
      Subscription subscription = Subscription.fromJson(response.data["body"]);
      return subscription;
    } else {
      throw response.data;
    }
  }
}
