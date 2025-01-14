import 'package:gym_manager_core/core.dart';

class UsersFilter implements Filter {
  String? name;
  bool hasEmail;
  bool hasPhone;
  bool hasPublicNote;
  bool hasPrivateNote;
  bool isArchived;
  bool isFlagged;
  bool isForceBlocked;
  int? courseId;
  int? idleDays;
  String? gender;
  int? years;
  List<ValidationResponseWarnings>? validationResponseWarnings;

  UsersFilter({
    this.name,
    bool? hasEmail,
    bool? hasPhone,
    bool? hasPrivateNote,
    bool? hasPublicNote,
    bool? isArchived,
    bool? isFlagged,
    bool? isForceBlocked,
    this.idleDays,
    this.gender,
    this.years,
    this.courseId,
    this.validationResponseWarnings,
  })  : hasEmail = hasEmail ?? false,
        hasPhone = hasPhone ?? false,
        hasPublicNote = hasPublicNote ?? false,
        hasPrivateNote = hasPrivateNote ?? false,
        isArchived = isArchived ?? false,
        isForceBlocked = isForceBlocked ?? false,
        isFlagged = isFlagged ?? false;

  @override
  clear() {
    name = null;
    hasEmail = false;
    hasPhone = false;
    hasPublicNote = false;
    hasPrivateNote = false;
    isArchived = false;
    isFlagged = false;
    isForceBlocked = false;
    courseId = null;
    validationResponseWarnings = null;
    idleDays = null;
    years = null;
    gender = null;
  }

  @override
  bool isClear() {
    return hasEmail == false &&
        hasPhone == false &&
        hasPublicNote == false &&
        hasPrivateNote == false &&
        isArchived == false &&
        isForceBlocked == false &&
        isFlagged == false &&
        courseId == null &&
        validationResponseWarnings == null &&
        years == null &&
        gender == null &&
        idleDays == null;
  }

  @override
  String toQueryParameters() {
    return 'courseId=$courseId&hasEmail=$hasEmail&hasPhone=$hasPhone&hasPublicNote=$hasPublicNote&hasPrivateNote=$hasPrivateNote&isArchived=$isArchived&isFlagged=$isFlagged&isForceBlocked=$isForceBlocked&idleDays=$idleDays&years=$years&gender=$gender&validationResponseWarnings=${validationResponseWarnings?.map((e) => e.name).join(",")}';
  }

  @override
  fromQueryParameters(Map<String, dynamic> map) {
    hasEmail = map['hasEmail'] == 'true';
    hasPhone = map['hasPhone'] == 'true';
    hasPublicNote = map['hasPublicNote'] == 'true';
    hasPrivateNote = map['hasPrivateNote'] == 'true';
    isArchived = map['isArchived'] == 'true';
    isFlagged = map['isFlagged'] == 'true';
    isForceBlocked = map['isForceBlocked'] == 'true';
    courseId = map['courseId'].toString() != 'null'
        ? int.tryParse(map['courseId'])
        : null;
    idleDays = map['idleDays'].toString() != 'null'
        ? int.tryParse(map['idleDays'])
        : null;
    years =
        map['years'].toString() != 'null' ? int.tryParse(map['years']) : null;
    gender = map['years'].toString() != 'null' ? map['years'].toString() : null;
    validationResponseWarnings =
        !(map['validationResponseWarnings'].toString()).contains('null')
            ? map['validationResponseWarnings'].toString().trim().isEmpty
                ? []
                : map['validationResponseWarnings']
                    .toString()
                    .split(',')
                    .map((e) => ValidationResponseWarnings.fromString(e))
                    .toList()
            : [];
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
      'isForceBlocked': isForceBlocked,
      'courseId': courseId,
      'gender': gender,
      'years': years,
      'idleDays': idleDays,
      'validationResponseWarnings':
          validationResponseWarnings?.map((e) => e.name).toList(),
    };
  }

  @override
  UsersFilter fromJson(Map<String, dynamic> json) {
    return UsersFilter(
      name: json['name'] as String?,
      hasEmail: json['hasEmail'] as bool? ?? false,
      hasPhone: json['hasPhone'] as bool? ?? false,
      hasPrivateNote: json['hasPrivateNote'] as bool? ?? false,
      hasPublicNote: json['hasPublicNote'] as bool? ?? false,
      isArchived: json['isArchived'] as bool? ?? false,
      isFlagged: json['isFlagged'] as bool? ?? false,
      isForceBlocked: json['isForceBlocked'] as bool? ?? false,
      courseId: json['courseId'] as int?,
      idleDays: json['idleDays'] as int?,
      gender: json['gender'] as String?,
      years: json['years'] as int?,
      validationResponseWarnings: (json['validationResponseWarnings']
                  as List<dynamic>?)
              ?.map((e) => ValidationResponseWarnings.fromString(e as String))
              .toList() ??
          [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UsersFilter) return false;
    return toJson().values.toList().sublist(1).toString() ==
        other.toJson().values.toList().sublist(1).toString();
  }

  @override
  int get hashCode {
    return toJson().hashCode;
  }
}
