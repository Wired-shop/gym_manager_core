abstract class Filter {
  Map<String, dynamic> toJson();
  Filter fromJson(Map<String, dynamic> json);
  String toQueryParameters();
  fromQueryParameters();
}
