class LicensePlan {
  final String name;
  final DateTime? expirationDateTime;
  final List<String> lockedSections;

  const LicensePlan({
    required this.name,
    this.expirationDateTime,
    this.lockedSections = const [],
  });

  factory LicensePlan.fromJson(Map<String, dynamic> json) => LicensePlan(
        name: json['name'] as String,
        expirationDateTime: json['expiresAt'] != null
            ? DateTime.parse(json['expiresAt'] as String)
            : null,
        lockedSections: (json['lockedSections'] as String? ?? '')
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'expiresAt': expirationDateTime?.toIso8601String(),
        'lockedSections': lockedSections.join(','),
      };

  bool isExpired() =>
      expirationDateTime != null && DateTime.now().isAfter(expirationDateTime!);

  bool hasSection(String sectionId) => lockedSections.contains(sectionId);
}
