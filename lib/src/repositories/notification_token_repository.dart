import 'package:supabase/supabase.dart';

class NotificationTokenRepository {
  final SupabaseClient _client;

  NotificationTokenRepository({required SupabaseClient client})
      : _client = client;

  Future<String?> getToken(
      {required String email, required String gymId}) async {
    final result = await _client
        .from('notificationTokens')
        .select('token')
        .eq('email', email)
        .eq('gymId', gymId)
        .maybeSingle();

    return result?['token'] as String?;
  }

  Future<void> setToken({
    required String email,
    required String token,
    required String gymId,
  }) async {
    await _client.from('notificationTokens').upsert({
      'email': email,
      'gymId': gymId,
      'token': token,
      'updatedAt': DateTime.now().toIso8601String(),
    }, onConflict: 'email,gymId');
  }
}
