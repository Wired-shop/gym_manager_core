import 'package:gym_manager_core/core.dart';

class ProductRepository {
  static Future<List<Product>> insert(List<Product> products) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products";
    final response = await ApiService.getInstance()
        .dio
        .post(url, data: products.map((e) => e.toJson()).toList());
    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }

  static Future<List<Product>> list() async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }

  static Future<Product> update(Product product) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products/";
    final response =
        await ApiService.getInstance().dio.put(url, data: product.toJson());
    return Product.fromJson(response.data);
  }

  static Future<Product?> get(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products/$id";
    final response = await ApiService.getInstance().dio.get(url);
    return response.data != null ? Product.fromJson(response.data) : null;
  }

  static Future<void> delete(int id) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/products/$id";
    await ApiService.getInstance().dio.delete(url);
  }
}
