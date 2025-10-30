import 'package:gym_manager_core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'entry.g.dart';

@JsonSerializable()
class Entry {
  int? id;
  int userId;
  int subscriptionId;

  DateTime date;
  EntryResponse response;

  Entry({
    this.id,
    required this.userId,
    required this.subscriptionId,
    required this.date,
    required this.response,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
