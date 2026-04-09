import 'dart:io';
import '../enums/document_type.dart';
import '../services/api_service.dart';

class FileRepository {
  static Future<File> download(String path) async {
    final file = File(path);
    file.createSync();
    file.writeAsBytesSync(await get(path));
    return file;
  }

  static Future<String> upload({
    required List<int> bytes,
    required int userId,
    required String extension,
    required DocumentType documentType,
  }) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/files";
    final response = await ApiService.getInstance().dio.post(url, data: {
      "bytes": bytes,
      "extension": extension,
      "fileName": documentType.name,
      "userId": userId,
    });
    return response.data["filePath"];
  }

  static Future<List<int>> get(String path) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/files?path=$path";
    final response = await ApiService.getInstance().dio.get(url);
    return (response.data as List).map<int>((e) => e).toList();
  }

  static Future<void> delete(String path) async {
    final url =
        "https://${ApiService.getInstance().getIP()}:${ApiService.getInstance().getPORT()}/files?path=$path";
    await ApiService.getInstance().dio.delete(url);
  }
}
