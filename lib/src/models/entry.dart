import 'package:gym_manager_backend/src/models/entry_result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'entry.g.dart';

@JsonSerializable()
class Entry {
  int userId;
  int subscriptionId;
  DateTime? date;
  EntryResult? result;

  Entry({
    required this.userId,
    required this.subscriptionId,
    required this.date,
    required this.result,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
