import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../enums/document_type.dart';
import '../services/api_service.dart';

class FileRepository {
  static Future<File> download({required String path}) async {
    File file = File(path);
    file.createSync();
    file.writeAsBytesSync(await get(path: path));
    return file;
  }

  static Future<String> upload(
      {required List<int> bytes,
      required int userId,
      required String extension,
      required DocumentType documentType}) async {
    String url =
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/files';
    Response response = await ApiService.getIstance().dio.post(
          url,
          data: {
            "bytes": bytes,
            "extension": extension,
            "fileName": documentType.name,
            "userId": userId,
          },
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      return response.data["body"].toString();
    }
    throw response.data;
  }

  static Future<List<int>> get({required String path}) async {
    Response response = await ApiService.getIstance().dio.get(
          'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/files/$path',
          options: Options(headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('${ApiService.getIstance().getUsername()}:${ApiService.getIstance().getPassword()}'))}'
          }),
        );
    if (response.data["responseType"] == "ok") {
      return (response.data["body"] as List).map<int>((e) => e).toList();
    } else {
      throw response.data;
    }
  }

  static Future delete({required String path}) async {
    String url =
        'http://${ApiService.getIstance().getIP()}:${ApiService.getIstance().getPORT()}/gyms/${ApiService.getIstance().getGymId()}/files/$path';
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
