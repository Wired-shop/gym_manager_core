import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class AutomationRepository {
  final SupabaseClient _client;

  AutomationRepository({required SupabaseClient client}) : _client = client;

  String get _gymId =>
      _client.auth.currentUser?.appMetadata['gymId'] as String? ?? '';

  Future<List<Automation>> list() async {
    final results = await _client
        .from('automations')
        .select()
        .eq('gymId', _gymId)
        .order('createdAt', ascending: true);

    return (results as List)
        .map((e) => Automation.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Automation> insert(Automation automation) async {
    final data = automation.toJson()
      ..remove('id')
      ..remove('createdAt');
    data['gymId'] = _gymId;

    final result =
        await _client.from('automations').insert(data).select().single();
    return Automation.fromJson(result);
  }

  Future<Automation> update(Automation automation) async {
    final data = automation.toJson()
      ..remove('id')
      ..remove('createdAt');
    data['gymId'] = _gymId;

    final result = await _client
        .from('automations')
        .update(data)
        .eq('id', automation.id!)
        .eq('gymId', _gymId)
        .select()
        .single();
    return Automation.fromJson(result);
  }

  Future<void> setEnabled({required int id, required bool enabled}) async {
    await _client
        .from('automations')
        .update({'enabled': enabled})
        .eq('id', id)
        .eq('gymId', _gymId);
  }

  Future<void> delete(int id) async {
    await _client.from('automations').delete().eq('id', id).eq('gymId', _gymId);
  }

  Future<int> countRecipients({
    required AutomationTrigger trigger,
    required AutomationTiming timing,
    required int offsetDays,
    required ComunicationChannel channel,
    required DateTime date,
  }) async {
    final result = await _client.rpc('countAutomationRecipients', params: {
      'pTrigger': trigger.name,
      'pTiming': timing.name,
      'pOffsetDays': timing == AutomationTiming.sameDay ? 0 : offsetDays,
      'pType': channel.name,
      'pDate': DateTime(date.year, date.month, date.day)
          .toIso8601String()
          .substring(0, 10),
    });
    return result as int;
  }
}
