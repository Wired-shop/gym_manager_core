import 'package:gym_manager_core/core.dart';
import 'package:gym_manager_core/src/enums/entry_rejection_reasons.dart';
import 'package:json_annotation/json_annotation.dart';
part 'entry.g.dart';

@JsonSerializable()
class Entry {
  int? id;
  int userId;
  int subscriptionId;

  DateTime date;
  EntryResponse response;

  List<EntryRejectionReason>? notEntryReasons;

  Entry({
    this.id,
    this.notEntryReasons,
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
