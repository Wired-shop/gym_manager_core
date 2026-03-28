import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';

class CoursePlanRepository {
  static Future<CoursePlan?> get(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans/$id";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      CoursePlan coursePlan = CoursePlan.fromJson(response.data["body"]);
      return coursePlan;
    } else {
      return null;
    }
  }

  static Future<List<CoursePlan>> list(int courseId) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans?courseId=$courseId";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<CoursePlan> coursePlans = (response.data["body"] as List<dynamic>)
          .map((e) => CoursePlan.fromJson(e))
          .toList();
      return coursePlans;
    } else {
      throw response.data;
    }
  }

  static Future<CoursePlan> insert(CoursePlan coursePlan) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans";
    Response response =
        await ApiService.getInstance().dio.post(url, data: coursePlan.toJson());
    if (response.data["responseType"] == "ok") {
      CoursePlan newCoursePlan = CoursePlan.fromJson(response.data["body"]);
      return newCoursePlan;
    } else {
      throw response.data;
    }
  }

  static Future<CoursePlan> update(CoursePlan coursePlan) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans/";
    Response response =
        await ApiService.getInstance().dio.put(url, data: coursePlan.toJson());
    if (response.data["responseType"] == "ok") {
      CoursePlan updatedCoursePlan = CoursePlan.fromJson(response.data["body"]);
      return updatedCoursePlan;
    } else {
      throw response.data;
    }
  }

  static Future delete(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/coursePlans/$id";
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
