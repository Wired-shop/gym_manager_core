import 'dart:convert';

import '../models/subscription.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static Future<void> truncate() async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/truncate";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }

  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions?badgeCode=$badgeCode&id=$id&userId=$userId";
    Response response = await ApiService.getInstance().dio.get(url);
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
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/all";
    Response response = await ApiService.getInstance().dio.get(url);
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
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions";
    Response response = await ApiService.getInstance()
        .dio
        .put(url, data: subscription.toJson());
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future<List<Subscription>> insert(
      List<Subscription> subscriptions) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions";
    List<Map<String, dynamic>> subscriptionsMapped =
        subscriptions.map((subscription) => subscription.toJson()).toList();
    Response response =
        await ApiService.getInstance().dio.post(url, data: subscriptionsMapped);
    if (response.data["responseType"] == "ok") {
      List<Subscription> insertedSubscriptions =
          (response.data["body"] as List<dynamic>)
              .map((e) => Subscription.fromJson(e))
              .toList();
      return insertedSubscriptions;
    } else {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/subscriptions/$id";
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
