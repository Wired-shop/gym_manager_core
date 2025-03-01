import 'dart:convert';

import '../models/subscription.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions?badgeCode=$badgeCode&id=$id&userId=$userId";
    Response response = await ApiService.getInstance().dio.get(
          url,
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
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/all";
    Response response = await ApiService.getInstance().dio.get(
          url,
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

  static Future import({required List<Subscription> subscriptions}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/import";
    List<Map<String, dynamic>> subscriptionsMapped =
        subscriptions.map((subscription) => subscription.toJson()).toList();
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: jsonEncode(subscriptionsMapped),
          options: Options(
            contentType: "application/json",
          ),
        );
    if (response.data["responseType"] == "ok") {
      return response.data["body"];
    } else {
      throw response.data;
    }
  }

  static Future update({required Subscription subscription}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions";
    Response response = await ApiService.getInstance().dio.put(
          url,
          data: subscription.toJson(),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future<Subscription> insert(
      {required Subscription subscription}) async {
    String url =
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions";
    Response response = await ApiService.getInstance().dio.post(
          url,
          data: subscription.toJson(),
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
        "http://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/$id";
    Response response = await ApiService.getInstance().dio.delete(
          url,
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
