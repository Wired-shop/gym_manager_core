import 'package:gym_manager_core/core.dart';

class License {
  final String? gymId;
  final String machineId;
  final DateTime? expiration;
  final List<LicensePlan> plans;
  final Gym? gym;
  final bool fromCache;

  const License({
    required this.machineId,
    this.gymId,
    this.expiration,
    this.plans = const [],
    this.gym,
    this.fromCache = false,
  });

  factory License.fromJson(
    Map<String, dynamic> json, {
    bool fromCache = false,
  }) =>
      License(
        machineId: json['machineId'] as String,
        gymId: json['gymId'] as String?,
        fromCache: fromCache,
        expiration: json['expiresAt'] != null
            ? DateTime.parse(json['expiresAt'] as String)
            : null,
        plans: (json['plans'] as List<dynamic>? ?? [])
            .map((e) => LicensePlan.fromJson(e as Map<String, dynamic>))
            .toList(),
        gym: json['gym'] != null
            ? Gym.fromJson(
                json['gym'] as Map<String, dynamic>,
                gymId: json['gymId'] as String? ?? '',
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        'machineId': machineId,
        'gymId': gymId,
        'expiresAt': expiration?.toIso8601String(),
        'fromCache': fromCache,
        'plans': plans.map((p) => p.toJson()).toList(),
        'gym': gym?.toJson(),
      };

  bool isExpired() => expiration != null && DateTime.now().isAfter(expiration!);
  bool hasPlan(String name) => plans.any((p) => p.name == name);
  bool isSectionUnlocked(String sectionId) {
    return plans
        .where((p) => !p.isExpired())
        .any((p) => p.lockedSections.contains(sectionId));
  }
}
