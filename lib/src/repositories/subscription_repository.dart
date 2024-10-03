import '../models/subscription.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions?badgeCode=$badgeCode&id=$id&userId=$userId";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Subscription subscription = Subscription.fromJson(response.data["body"]);
      return subscription;
    } else {
      return null;
    }
  }

  static Future<List<Subscription>> list() async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
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

  static Future update({required Subscription subscription}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions";
    Response response = await ApiService.getIstance().dio.put(
          url,
          data: subscription.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future insert({required Subscription subscription}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: subscription.toJson(),
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "ok") {
      Subscription newSubscription =
          Subscription.fromJson(response.data["body"]);
      return newSubscription;
    } else {
      throw response.data;
    }
  }

  static Future delete({required int id}) async {
    String url =
        "http://${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions/$id";
    Response response = await ApiService.getIstance().dio.delete(
          url,
          options: ApiService.getIstance().getAuthCredentials(),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
