abstract class Filter {
  Map<String, dynamic> toJson();
  Filter fromJson(Map<String, dynamic> json);
  String toQueryParameters();
  fromQueryParameters();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Filter) return false;
    return toJson() == other.toJson();
  }

  @override
  int get hashCode {
    return toJson().hashCode;
  }
}
