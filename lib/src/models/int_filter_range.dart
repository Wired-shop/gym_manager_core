class IntFilterRange {
  int? start;
  int? end;

  IntFilterRange({this.start, this.end});

  String toQueryParameters() {
    return "$start-$end";
  }

  static IntFilterRange? fromQueryParameters(
      {required Map<String, dynamic> map, required String intFilterRangeName}) {
    if (!map.containsKey(intFilterRangeName)) return null;
    String value = map[intFilterRangeName].toString();
    if (value == "null") return null;
    List<String> parts = value.toString().split("-");
    return IntFilterRange(
        start: int.tryParse(parts[0]), end: int.tryParse(parts[1]));
  }
}
