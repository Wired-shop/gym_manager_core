abstract class Filter {
  bool isClear();
  clear();
  Map<String, dynamic> toJson();
  Filter fromJson(Map<String, dynamic> json);
  String toQueryParameters();
  fromQueryParameters(Map<String, dynamic> queryParameters);
}
