import 'package:gym_manager_core/src/enums/campaign_status.dart';
import 'package:gym_manager_core/src/enums/campaign_type.dart';
import 'package:gym_manager_core/src/models/campaign_user.dart';

class Campaign {
  int? id;
  String name;
  String? description;
  String? attachmentUrl;
  List<CampaignUser> users;
  DateTime? scheduledAt;
  CampaignStatus status;
  CampaignType type;
  int? success;

  Campaign({
    this.id,
    required this.name,
    this.description,
    this.attachmentUrl,
    required this.users,
    this.scheduledAt,
    required this.status,
    required this.type,
    this.success,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'attachmentUrl': attachmentUrl,
        'users': users.map((e) => e.toJson()).toList(),
        'scheduledAt': scheduledAt?.toIso8601String(),
        'status': status.name,
        'type': type.name,
        'success': success,
      };

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json['id'] as int?,
        name: json['name'] as String,
        description: json['description'] as String?,
        attachmentUrl: json['attachmentUrl'] as String?,
        users: (json['users'] as List<dynamic>? ?? [])
            .map((e) => CampaignUser.fromJson(e as Map<String, dynamic>))
            .toList(),
        scheduledAt: json['scheduledAt'] != null
            ? DateTime.parse(json['scheduledAt'] as String)
            : null,
        status: CampaignStatus.fromString(json['status'] as String),
        type: CampaignType.fromString(json['type'] as String),
        success: json['success'] as int?,
      );

  @override
  String toString() => toJson().toString();
}
