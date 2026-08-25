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

  Future<void> deleteNotification({required String id}) async {
    try {
      await _client.from('notifications').delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw Exception('Errore nell\'eliminazione della notifica: ${e.message}');
    }
  }
}
