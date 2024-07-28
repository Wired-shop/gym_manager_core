import 'package:gym_manager_backend/backend.dart';
import 'package:gym_manager_backend/src/models/filter.dart';

class UsersFilter implements Filter {
  bool? hasEmail;
  bool? hasPhone;
  bool? hasPublicNote;
  bool? hasPrivateNote;
  bool? isArchived;
  bool? isFlagged;
  List<ValidationResponseWarnings>? validationResponseWarnings;

  UsersFilter({
    this.hasEmail,
    this.hasPhone,
    this.hasPrivateNote,
    this.hasPublicNote,
    this.isArchived,
    this.isFlagged,
    this.validationResponseWarnings,
  });

  @override
  String toQueryParameters() {
    return 'hasEmail=$hasEmail&hasPhone=$hasPhone&hasPublicNote=$hasPublicNote&hasPrivateNote=$hasPrivateNote&isArchived=$isArchived&isFlagged=$isFlagged&validationResponseWarnings=${validationResponseWarnings.toString().replaceAll('[', '').replaceAll(']', '').trim()}';
  }

  @override
  fromQueryParameters() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasEmail': hasEmail,
      'hasPhone': hasPhone,
      'hasPrivateNote': hasPrivateNote,
      'hasPublicNote': hasPublicNote,
      'isFlagged': isFlagged,
      'isArchived': isArchived,
      'validationResponseWarnings':
          validationResponseWarnings?.map((e) => e.name).toList()
    };
  }

  @override
  UsersFilter fromJson(Map<String, dynamic> json) {
    return UsersFilter(
        hasEmail: json['hasEmail'] as bool?,
        hasPhone: json['hasPhone'] as bool?,
        hasPrivateNote: json['hasPrivateNote'] as bool?,
        hasPublicNote: json['hasPublicNote'] as bool?,
        isArchived: json['isArchived'] as bool?,
        isFlagged: json['isFlagged'] as bool?,
        validationResponseWarnings: (json['validationResponseWarnings'] as List)
            .map((e) => ValidationResponseWarnings.fromValue(e.toString()))
            .toList());
  }
}
