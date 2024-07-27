import 'dart:io';
import 'package:dio/dio.dart';
import '../enums/document_type.dart';
import '../services/api_service.dart';

class FileRepository {
  static final Dio _dio = Dio();

  static Future<File> download(String path) async {
    File file = File(path);
    file.createSync();
    file.writeAsBytesSync(await get(path));
    return file;
  }

  static Future<String> upload(
      {required List<int> bytes,
      required int userId,
      required String extension,
      required DocumentType documentType}) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/files?fileName=${documentType.name}&userId=$userId";
    Response response =
        await _dio.post(url, data: {"bytes": bytes, "extension": extension});
    if (response.data["responseType"] == "ok") {
      return response.data["body"].toString();
    } else {
      throw response.data;
    }
  }

  static Future<List<int>> get(String path) async {
    Response response = await _dio.get(
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/files?path=$path");
    if (response.data["responseType"] == "ok") {
      return (response.data["body"] as List<dynamic>)
          .map<int>((e) => e)
          .toList();
    } else {
      throw response.data;
    }
  }

  static Future<void> delete(String path) async {
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/files?path=$path";
    Response response = await _dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
