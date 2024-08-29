import 'package:json_annotation/json_annotation.dart';
part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  int? id;
  int userId;
  int? courseId;
  DateTime expiration;
  DateTime? creation;
  String? badgeCode;
  int? dailyAccessLimit;

  Subscription({
    this.id,
    required this.userId,
    required this.expiration,
    this.creation,
    this.courseId,
    this.badgeCode,
    this.dailyAccessLimit,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
