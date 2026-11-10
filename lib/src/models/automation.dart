import 'package:gym_manager_core/src/enums/automation_trigger.dart';
import 'package:gym_manager_core/src/enums/comunication_channel.dart';

class Automation {
  int? id;
  String gymId;
  String name;
  AutomationTrigger trigger;
  int offsetDays;
  int sendHour;
  bool enabled;
  ComunicationChannel channel;
  String? description;
  String? attachmentUrl;
  int? whatsappTemplateId;
  Map<String, String>? whatsappTemplateFields;
  DateTime? createdAt;

  Automation({
    this.id,
    this.gymId = '',
    required this.name,
    required this.trigger,
    required this.offsetDays,
    required this.sendHour,
    required this.enabled,
    required this.channel,
    this.description,
    this.attachmentUrl,
    this.whatsappTemplateId,
    this.whatsappTemplateFields,
    this.createdAt,
  });

  String toRuleString() {
    final hour = "alle ${sendHour.toString().padLeft(2, '0')}:00";
    if (!trigger.usesOffset || offsetDays == 0) {
      return "Il giorno ${trigger.eventLabel()} $hour";
    }
    final days = offsetDays.abs();
    final when = offsetDays < 0 ? "prima" : "dopo";
    return "${days == 1 ? '1 giorno' : '$days giorni'} $when "
        "${trigger.eventLabel()} $hour";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'gymId': gymId,
        'name': name,
        'trigger': trigger.name,
        'offsetDays': offsetDays,
        'sendHour': sendHour,
        'enabled': enabled,
        'type': channel.name,
        'description': description,
        'attachmentUrl': attachmentUrl,
        'whatsappTemplateId': whatsappTemplateId,
        'whatsappTemplateFields': whatsappTemplateFields,
        'createdAt': createdAt?.toIso8601String(),
      };

  factory Automation.fromJson(Map<String, dynamic> json) => Automation(
        id: json['id'] as int?,
        gymId: json['gymId'] as String? ?? '',
        name: json['name'] as String,
        trigger: AutomationTrigger.fromString(json['trigger'] as String),
        offsetDays: json['offsetDays'] as int? ?? 0,
        sendHour: json['sendHour'] as int? ?? 9,
        enabled: json['enabled'] as bool? ?? true,
        channel: ComunicationChannel.fromString(json['type'] as String),
        description: json['description'] as String?,
        attachmentUrl: json['attachmentUrl'] as String?,
        whatsappTemplateId: json['whatsappTemplateId'] as int?,
        whatsappTemplateFields:
            (json['whatsappTemplateFields'] as Map<String, dynamic>?)
                ?.map((key, value) => MapEntry(key, value.toString())),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
      );

  @override
  String toString() => toJson().toString();
}
