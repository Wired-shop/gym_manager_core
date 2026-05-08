import 'package:gym_manager_core/core.dart';

class LicenseValidationResult {
  final License? license;
  final DateTime? tokenExpiration;
  final LicenseValidationResultStatus status;

  const LicenseValidationResult({
    required this.license,
    required this.tokenExpiration,
    required this.status,
  });

  factory LicenseValidationResult.empty(LicenseValidationResultStatus status) {
    return LicenseValidationResult(
      license: null,
      tokenExpiration: null,
      status: status,
    );
  }

  bool isValid() => status == LicenseValidationResultStatus.valid;

  LicenseValidationResult copyWith({
    License? license,
    DateTime? tokenExpiration,
    LicenseValidationResultStatus? status,
  }) {
    return LicenseValidationResult(
      license: license ?? this.license,
      tokenExpiration: tokenExpiration ?? this.tokenExpiration,
      status: status ?? this.status,
    );
  }
}
