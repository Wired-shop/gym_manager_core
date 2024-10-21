import 'dart:convert';

import '../models/subscription.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class SubscriptionRepository {
  static Future<Subscription?> get(
      {int? id, String? badgeCode, int? userId}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions?badgeCode=$badgeCode&id=$id&userId=$userId";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Subscription subscription = Subscription.fromJson(response.data["body"]);
      return subscription;
    } else {
      return null;
    }
  }

   static Future import({required List<Subscription> subscriptions}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions/import";
    List<Map<String, dynamic>> subscriptionsMapped =
        subscriptions.map((subscription) => subscription.toJson()).toList();
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: jsonEncode(subscriptionsMapped),
          options: Options(
            contentType: "application/json",
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
            },
          ),
        );
    if (response.data["responseType"] == "ok") {
      return response.data["body"];
    } else {
      throw response.data;
    }
  }

  static Future<List<Subscription>> list() async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions";
    Response response = await ApiService.getIstance().dio.get(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions";
    Response response = await ApiService.getIstance().dio.put(
          url,
          data: subscription.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }

  static Future<Subscription> insert(
      {required Subscription subscription}) async {
    String url =
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions";
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: subscription.toJson(),
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
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
        "http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/subscriptions/$id";
    Response response = await ApiService.getIstance().dio.delete(
          url,
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
