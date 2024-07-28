import 'package:gym_manager_backend/backend.dart';

class UsersFilter implements Filter {
  String? name;
  bool? hasEmail;
  bool? hasPhone;
  bool? hasPublicNote;
  bool? hasPrivateNote;
  bool? isArchived;
  bool? isFlagged;
  ValidationResponse? validationResponse;
  List<ValidationResponseWarnings>? validationResponseWarnings = [];

  UsersFilter({
    this.name,
    this.hasEmail,
    this.hasPhone,
    this.hasPrivateNote,
    this.hasPublicNote,
    this.isArchived,
    this.isFlagged,
    this.validationResponse,
    this.validationResponseWarnings,
  });

  @override
  String toQueryParameters() {
    return 'hasEmail=$hasEmail&hasPhone=$hasPhone&hasPublicNote=$hasPublicNote&hasPrivateNote=$hasPrivateNote&isArchived=$isArchived&isFlagged=$isFlagged&validationResponse=${validationResponse?.name}&validationResponseWarnings=${validationResponseWarnings.toString().replaceAll('[', '').replaceAll(']', '').trim()}';
  }

  @override
  fromQueryParameters() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hasEmail': hasEmail,
      'hasPhone': hasPhone,
      'hasPrivateNote': hasPrivateNote,
      'hasPublicNote': hasPublicNote,
      'isFlagged': isFlagged,
      'isArchived': isArchived,
      'validationResponse': validationResponse?.name,
      'validationResponseWarnings':
          validationResponseWarnings?.map((e) => e.name).toList()
    };
  }

  @override
  UsersFilter fromJson(Map<String, dynamic> json) {
    return UsersFilter(
        name: json['name'] as String?,
        hasEmail: json['hasEmail'] as bool?,
        hasPhone: json['hasPhone'] as bool?,
        hasPrivateNote: json['hasPrivateNote'] as bool?,
        hasPublicNote: json['hasPublicNote'] as bool?,
        isArchived: json['isArchived'] as bool?,
        isFlagged: json['isFlagged'] as bool?,
        validationResponse:
            ValidationResponse.fromValue(json['validationResponse'] as String?),
        validationResponseWarnings: (json['validationResponseWarnings'] as List)
            .map((e) => ValidationResponseWarnings.fromValue(e.toString()))
            .toList());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UsersFilter) return false;
    return toJson().toString() == other.toJson().toString();
  }

  @override
  int get hashCode {
    return toJson().hashCode;
  }
}
