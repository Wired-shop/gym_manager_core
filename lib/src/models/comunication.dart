import 'package:gym_manager_core/src/enums/comunication_status.dart';
import 'package:gym_manager_core/src/enums/comunication_channel.dart';
import 'package:gym_manager_core/src/models/comunication_user.dart';

class Comunication {
  int? id;
  String gymId;
  String name;
  String? description;
  String? attachmentUrl;
  List<ComunicationUser> users;
  DateTime? scheduledAt;
  DateTime? createdAt;
  ComunicationStatus status;
  ComunicationChannel channel;
  int? success;

  Comunication({
    this.id,
    this.gymId = '',
    required this.name,
    this.description,
    this.attachmentUrl,
    required this.users,
    this.scheduledAt,
    this.createdAt,
    required this.status,
    required this.channel,
    this.success,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'gymId': gymId,
        'name': name,
        'description': description,
        'attachmentUrl': attachmentUrl,
        'users': users.map((e) => e.toJson()).toList(),
        'scheduledAt': scheduledAt?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'status': status.name,
        'type': channel.name,
        'success': success,
      };

  factory Comunication.fromJson(Map<String, dynamic> json) => Comunication(
        id: json['id'] as int?,
        gymId: json['gymId'] as String? ?? '',
        name: json['name'] as String,
        description: json['description'] as String?,
        attachmentUrl: json['attachmentUrl'] as String?,
        users: (json['users'] as List<dynamic>? ?? [])
            .map((e) => ComunicationUser.fromJson(e as Map<String, dynamic>))
            .toList(),
        scheduledAt: json['scheduledAt'] != null
            ? DateTime.parse(json['scheduledAt'] as String)
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        status: ComunicationStatus.fromString(json['status'] as String),
        channel: ComunicationChannel.fromString(json['type'] as String),
        success: json['success'] as int?,
      );

  @override
  String toString() => toJson().toString();
}
