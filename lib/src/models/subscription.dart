import 'package:json_annotation/json_annotation.dart';
part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  int? id;
  int userId;
  int? courseId;
  int? coursePlanId;

  DateTime? creation;
  DateTime expiration;
  String? badgeCode;
  int? accessesAvaiable;

  Subscription({
    this.id,
    required this.userId,
    required this.expiration,
    this.coursePlanId,
    this.courseId,
    this.badgeCode,
    this.accessesAvaiable,
    this.creation,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
