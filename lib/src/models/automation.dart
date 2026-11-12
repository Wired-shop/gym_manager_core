import 'package:gym_manager_core/src/enums/automation_timing.dart';
import 'package:gym_manager_core/src/enums/automation_trigger.dart';
import 'package:gym_manager_core/src/enums/comunication_channel.dart';

class Automation {
  int? id;
  String gymId;
  String name;
  bool enabled;

  AutomationTrigger trigger;
  AutomationTiming timing;
  int offsetDays;
  int sendHour;

  String comunicationTitle;
  String? comunicationDescription;
  ComunicationChannel channel;
  int? whatsappTemplateId;
  Map<String, String>? whatsappTemplateFields;
  String? attachmentUrl;

  DateTime? createdAt;

  Automation({
    this.id,
    this.gymId = '',
    required this.name,
    this.enabled = true,
    required this.trigger,
    this.timing = AutomationTiming.sameDay,
    this.offsetDays = 0,
    this.sendHour = 9,
    required this.comunicationTitle,
    this.comunicationDescription,
    required this.channel,
    this.whatsappTemplateId,
    this.whatsappTemplateFields,
    this.attachmentUrl,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'gymId': gymId,
        'name': name,
        'enabled': enabled,
        'trigger': trigger.name,
        'timing': timing.name,
        'offsetDays': timing == AutomationTiming.sameDay ? 0 : offsetDays,
        'sendHour': sendHour,
        'comunicationTitle': comunicationTitle,
        'comunicationDescription': comunicationDescription,
        'type': channel.name,
        'whatsappTemplateId': whatsappTemplateId,
        'whatsappTemplateFields': whatsappTemplateFields,
        'attachmentUrl': attachmentUrl,
        'createdAt': createdAt?.toIso8601String(),
      };

  factory Automation.fromJson(Map<String, dynamic> json) => Automation(
        id: json['id'] as int?,
        gymId: json['gymId'] as String? ?? '',
        name: json['name'] as String,
        enabled: json['enabled'] as bool? ?? true,
        trigger: AutomationTrigger.fromString(json['trigger'] as String),
        timing: AutomationTiming.fromString(
            json['timing'] as String? ?? AutomationTiming.sameDay.name),
        offsetDays: json['offsetDays'] as int? ?? 0,
        sendHour: json['sendHour'] as int? ?? 9,
        comunicationTitle: json['comunicationTitle'] as String,
        comunicationDescription: json['comunicationDescription'] as String?,
        channel: ComunicationChannel.fromString(json['type'] as String),
        whatsappTemplateId: json['whatsappTemplateId'] as int?,
        whatsappTemplateFields:
            (json['whatsappTemplateFields'] as Map<String, dynamic>?)
                ?.map((key, value) => MapEntry(key, value.toString())),
        attachmentUrl: json['attachmentUrl'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
      );

  @override
  String toString() => toJson().toString();
}
