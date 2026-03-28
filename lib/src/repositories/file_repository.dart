import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../enums/document_type.dart';
import '../services/api_service.dart';

class FileRepository {
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
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/files';
    Response response = await ApiService.getInstance().dio.post(url, data: {
      "bytes": bytes,
      "extension": extension,
      "fileName": documentType.name,
      "userId": userId,
    });
    if (response.data["responseType"] == "ok") {
      return response.data["body"]["filePath"];
    }
    throw response.data;
  }

  static Future<List<int>> get(String path) async {
    Response response = await ApiService.getInstance().dio.get(
          'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/files?path=$path',
        );
    if (response.data["responseType"] == "ok") {
      return (response.data["body"] as List).map<int>((e) => e).toList();
    } else {
      throw response.data;
    }
  }

  static Future delete(String path) async {
    String url =
        'https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/files?path=$path';
    Response response = await ApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
