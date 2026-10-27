import 'package:gym_manager_core/core.dart';

class UsersFilter implements Filter {
  String? name;
  bool? hasEmail;
  bool? hasPhone;

  /// Ha l'app degli iscritti (token push per la palestra su Supabase).
  /// Non lo applica il backend: lo applica il gestionale sulla lista ricevuta.
  bool? hasApp;
  bool? hasTpPro;
  bool? hasPublicNote;
  bool? hasPrivateNote;
  bool? isArchived;
  bool? isFlagged;
  bool? isForceBlocked;
  int? courseId;
  int? idleDays;
  String? gender;
  IntFilterRange? yearsRange;
  int? creation;
  List<ValidationResponseWarnings>? validationResponseWarnings;

  /// Stati dell'abbonamento da includere (in OR). Per Problemi e Non valido
  /// l'utente deve avere anche almeno uno dei [validationResponseWarnings].
  /// Se null vale il vecchio comportamento basato solo sui motivi.
  List<ValidationResponse>? validationResponses;

  /// Giorni entro cui una scadenza conta come "in scadenza". Se null il
  /// backend usa la sua preferenza.
  int? inExpiringDays;

  UsersFilter({
    this.name,
    bool? hasEmail,
    bool? hasTpPro,
    bool? hasPhone,
    bool? hasApp,
    bool? hasPrivateNote,
    bool? hasPublicNote,
    bool? isArchived,
    bool? isFlagged,
    bool? isForceBlocked,
    IntFilterRange? yearsRange,
    this.idleDays,
    this.gender,
    this.courseId,
    this.creation,
    this.validationResponseWarnings,
    this.validationResponses,
    this.inExpiringDays,
  })  : yearsRange = yearsRange ?? IntFilterRange(),
        hasEmail = hasEmail ?? false,
        hasTpPro = hasTpPro ?? false,
        hasPhone = hasPhone ?? false,
        hasApp = hasApp ?? false,
        hasPublicNote = hasPublicNote ?? false,
        hasPrivateNote = hasPrivateNote ?? false,
        isArchived = isArchived ?? false,
        isForceBlocked = isForceBlocked ?? false,
        isFlagged = isFlagged ?? false;

  @override
  clear() {
    name = null;
    hasEmail = false;
    hasTpPro = false;
    hasPhone = false;
    hasApp = false;
    hasPublicNote = false;
    hasPrivateNote = false;
    isArchived = false;
    isFlagged = false;
    isForceBlocked = false;
    courseId = null;
    validationResponseWarnings = null;
    validationResponses = null;
    inExpiringDays = null;
    idleDays = null;
    yearsRange = IntFilterRange();
    gender = null;
    creation = null;
  }

  @override
  bool isClear() {
    return hasEmail == false &&
        hasTpPro == false &&
        hasPhone == false &&
        hasApp == false &&
        hasPublicNote == false &&
        hasPrivateNote == false &&
        isArchived == false &&
        isForceBlocked == false &&
        isFlagged == false &&
        courseId == null &&
        validationResponseWarnings == null &&
        validationResponses == null &&
        (yearsRange?.start == null && yearsRange?.end == null) &&
        gender == null &&
        idleDays == null &&
        creation == null;
  }

  @override
  String toQueryParameters() {
    String encodedValidationResponseWarnings =
        validationResponseWarnings?.map((e) => e.name).join(",") ?? "null";
    String encodedValidationResponses =
        validationResponses?.map((e) => e.name).join(",") ?? "null";
    return 'courseId=$courseId&hasEmail=$hasEmail&hasTpPro=$hasTpPro&hasPhone=$hasPhone&hasApp=$hasApp&hasPublicNote=$hasPublicNote&hasPrivateNote=$hasPrivateNote&isArchived=$isArchived&isFlagged=$isFlagged&isForceBlocked=$isForceBlocked&idleDays=$idleDays&yearsRange=${yearsRange?.toQueryParameters()}&gender=$gender&creation=$creation&validationResponseWarnings=$encodedValidationResponseWarnings&inExpiringDays=$inExpiringDays&validationResponses=$encodedValidationResponses';
  }

  @override
  fromQueryParameters(Map<String, dynamic> map) {
    hasEmail = map['hasEmail'] == 'true';
    hasTpPro = map['hasTpPro'] == 'true';
    hasPhone = map['hasPhone'] == 'true';
    hasApp = map['hasApp'] == 'true';
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
    yearsRange = IntFilterRange.fromQueryParameters(
        map: map, intFilterRangeName: "yearsRange");
    gender =
        map['gender'].toString() != 'null' ? map['gender'].toString() : null;
    creation = map['creation'].toString() != 'null'
        ? int.tryParse(map['creation'])
        : null;
    validationResponses =
        _parseValidationResponses(map['validationResponses']?.toString());
    inExpiringDays = map['inExpiringDays'].toString() != 'null'
        ? int.tryParse(map['inExpiringDays'])
        : null;
    validationResponseWarnings = map.containsKey("validationResponseWarnings")
        ? !(map['validationResponseWarnings'].toString()).contains('null')
            ? map['validationResponseWarnings'].toString().trim().isEmpty
                ? []
                : map['validationResponseWarnings']
                    .toString()
                    .split(',')
                    .map((e) => ValidationResponseWarnings.fromString(e))
                    .toList()
            : null
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hasEmail': hasEmail,
      'hasTpPro': hasTpPro,
      'hasPhone': hasPhone,
      'hasApp': hasApp,
      'hasPrivateNote': hasPrivateNote,
      'hasPublicNote': hasPublicNote,
      'isFlagged': isFlagged,
      'isArchived': isArchived,
      'isForceBlocked': isForceBlocked,
      'courseId': courseId,
      'gender': gender,
      'yearsRange': yearsRange?.toQueryParameters(),
      'idleDays': idleDays,
      'creation': creation,
      'validationResponseWarnings':
          validationResponseWarnings?.map((e) => e.name).toList(),
      'inExpiringDays': inExpiringDays,
      'validationResponses': validationResponses?.map((e) => e.name).toList(),
    };
  }

  @override
  UsersFilter fromJson(Map<String, dynamic> json) {
    final warnings = (json['validationResponseWarnings'] as List<dynamic>?)
        ?.map((e) => ValidationResponseWarnings.fromString(e as String))
        .toList();
    return UsersFilter(
      name: json['name'] as String?,
      hasEmail: json['hasEmail'] as bool? ?? false,
      hasTpPro: json['hasTpPro'] as bool? ?? false,
      hasPhone: json['hasPhone'] as bool? ?? false,
      hasApp: json['hasApp'] as bool? ?? false,
      hasPrivateNote: json['hasPrivateNote'] as bool? ?? false,
      hasPublicNote: json['hasPublicNote'] as bool? ?? false,
      isArchived: json['isArchived'] as bool? ?? false,
      isFlagged: json['isFlagged'] as bool? ?? false,
      isForceBlocked: json['isForceBlocked'] as bool? ?? false,
      courseId: json['courseId'] as int?,
      idleDays: json['idleDays'] as int?,
      gender: json['gender'] as String?,
      yearsRange: IntFilterRange.fromQueryParameters(
          map: json, intFilterRangeName: "yearsRange"),
      creation: json['creation'] as int?,
      validationResponseWarnings: warnings,
      inExpiringDays: json['inExpiringDays'] as int?,
      validationResponses: json.containsKey('validationResponses')
          ? (json['validationResponses'] as List<dynamic>?)
              ?.map((e) => ValidationResponse.values.byName(e as String))
              .toList()
          : _legacyValidationResponses(warnings),
    );
  }

  /// Filtri salvati prima degli stati multipli: avevano solo i motivi, con la
  /// lista vuota per "Valido".
  static List<ValidationResponse>? _legacyValidationResponses(
      List<ValidationResponseWarnings>? warnings) {
    if (warnings == null) return null;
    if (warnings.isEmpty) return [ValidationResponse.valid];
    return ValidationResponse.values
        .where((r) => (ValidationResult.associatedWarningsOf(r) ?? [])
            .any(warnings.contains))
        .toList();
  }

  static List<ValidationResponse>? _parseValidationResponses(String? value) {
    if (value == null || value == 'null') return null;
    return value
        .split(',')
        .map((e) => ValidationResponse.values.asNameMap()[e.trim()])
        .whereType<ValidationResponse>()
        .toList();
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
