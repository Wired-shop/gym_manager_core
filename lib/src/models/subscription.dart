import 'package:json_annotation/json_annotation.dart';
part 'subscription.g.dart';


@JsonSerializable()
class Subscription {
  int userId;
  int? id;
  DateTime? creation;
  DateTime expiration;
  String? badgeCode;
  int? dailyAccessLimit;

  Subscription({
    this.id,
    required this.userId,
    this.badgeCode,
    this.dailyAccessLimit,
    this.creation,
    required this.expiration,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
