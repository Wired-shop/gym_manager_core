import '../enums/validation_response.dart';
import '../enums/validation_response_warnings.dart';
import 'package:json_annotation/json_annotation.dart';
part 'validation_result.g.dart';

@JsonSerializable()
class ValidationResult {
  ValidationResponse response;
  List<ValidationResponseWarnings> warnings;

  ValidationResult(this.response, this.warnings);

  factory ValidationResult.fromJson(Map<String, dynamic> json) =>
      _$ValidationResultFromJson(json);
  Map<String, dynamic> toJson() => _$ValidationResultToJson(this);
}
