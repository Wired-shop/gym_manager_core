import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class NotificationRepository {
  final SupabaseClient _client;

  NotificationRepository({required SupabaseClient client}) : _client = client;

  Future<List<Notification>> getNotifications(
      {required String email, required String gymId}) async {
    try {
      final result = await _client
          .from('notifications')
          .select()
          .eq('gymId', gymId)
          .eq('email', email)
          .order('createdAt', ascending: false);

      return (result as List<dynamic>)
          .map((json) => Notification.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Errore nel recupero delle notifiche: ${e.message}');
    }
  }

  Future<void> markAllAsViewed({
    required String email,
    required String gymId,
  }) async {
    try {
      await _client
          .from('notifications')
          .update({'viewed': true})
          .eq('gymId', gymId)
          .eq('email', email)
          .eq('viewed', false);
    } on PostgrestException catch (e) {
      throw Exception(
          'Errore nell\'aggiornamento delle notifiche: ${e.message}');
    }
  }
}
