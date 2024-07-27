import '../models/subscription.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static final Dio _dio = Dio();

  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/subscriptions?id=$id&badgeCode=$badgeCode&userId=$userId";
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
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/subscriptions";
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

  static Future<Subscription> update(Subscription subscription) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/subscriptions";
    Response response = await _dio.put(url, data: subscription.toJson());
    if (response.data["responseType"] == "ok") {
      return Subscription.fromJson(response.data["body"]);
    } else {
      throw response.data;
    }
  }

  static Future<Subscription> insert(Subscription subscription) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/subscriptions";
    Response response = await _dio.post(url, data: subscription.toJson());
    if (response.data["responseType"] == "ok") {
      return Subscription.fromJson(response.data["body"]);
    } else {
      throw response.data;
    }
  }
}
