class IntFilterRange {
  int? start;
  int? end;

  IntFilterRange({this.start, this.end});

  String toQueryParameters() {
    return "[$start-$end]";
  }

  static IntFilterRange? fromQueryParameters(
      {required Map<String, dynamic> map, required String intFilterRangeName}) {
    if (!map.containsKey(intFilterRangeName)) return null;

    String value = map[intFilterRangeName].toString();
    if (value == "null") return null;

    String rangeString = value.toString();

    if (!rangeString.startsWith('[') || !rangeString.endsWith(']')) {
      throw ArgumentError("Formato range non valido: $rangeString");
    }

    rangeString = rangeString.substring(1, rangeString.length - 1);
    List<String> parts = rangeString.split('-');

    if (parts.length != 2) {
      throw ArgumentError("Formato range non valido: $rangeString");
    }

    int? start = int.tryParse(parts[0]);
    int? end = int.tryParse(parts[1]);

    return IntFilterRange(start: start, end: end);
  }
}
