import 'package:gym_manager_backend/backend.dart';
import 'package:gym_manager_backend/src/enums/entry_response_warnings.dart';
import 'package:json_annotation/json_annotation.dart';
part 'entry_result.g.dart';

@JsonSerializable()
class EntryResult {
  EntryResponse response;
  List<EntryResponseWarnings> warnings;

  EntryResult(this.response, this.warnings);

  setEntryResponse(EntryResponse response) {
    this.response = response;
  }

  addEntryResponseWarning(EntryResponseWarnings warning) {
    warnings.add(warning);
  }

  factory EntryResult.fromJson(Map<String, dynamic> json) =>
      _$EntryResultFromJson(json);
  Map<String, dynamic> toJson() => _$EntryResultToJson(this);
}
