class Configs {
  int? inExpiringDays;

  Configs({this.inExpiringDays});

  Map<String, dynamic> toJson() {
    return {"inExpiringDays": inExpiringDays};
  }

  factory Configs.fromJson(Map<String, dynamic> json) {
    return Configs(
      inExpiringDays: json['inExpiringDays'] as int?,
    );
  }
}
