import 'package:dio/dio.dart';
import 'package:gym_manager_core/core.dart';
import 'dart:convert';

class ProductRepository {
  static Future<List<Product>> insert(List<Product> products) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products";
    List<Map<String, dynamic>> productsMapped =
        products.map((product) => product.toJson()).toList();
    Response response =
        await ApiService.getInstance().dio.post(url, data: productsMapped);
    if (response.data["responseType"] == "ok") {
      List<Product> insertedProducts = (response.data["body"] as List<dynamic>)
          .map((e) => Product.fromJson(e))
          .toList();
      return insertedProducts;
    } else {
      throw response.data;
    }
  }

  static Future<List<Product>> list() async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products';
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<Product> products = (response.data["body"] as List<dynamic>)
          .map((e) => Product.fromJson(e))
          .toList();
      return products;
    } else {
      throw response.data;
    }
  }

  static Future<Product> update(Product product) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products/";
    Response response =
        await ApiService.getInstance().dio.put(url, data: product.toJson());
    if (response.data["responseType"] == "ok") {
      Product updatedProduct = Product.fromJson(response.data["body"]);
      return updatedProduct;
    } else {
      throw response.data;
    }
  }

  static Future<Product?> get(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products/$id";
    Response response = await ApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok" &&
        response.data["body"] != null) {
      Product product = Product.fromJson(response.data["body"]);
      return product;
    } else {
      return null;
    }
  }

  static Future delete(int id) async {
    String url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products/$id";
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
