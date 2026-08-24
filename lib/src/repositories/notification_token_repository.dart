import 'package:supabase/supabase.dart';

class NotificationTokenRepository {
  final SupabaseClient _client;

  NotificationTokenRepository({required SupabaseClient client})
      : _client = client;

  String get _gymId =>
      _client.auth.currentUser?.userMetadata?['gymId'] as String? ?? '';

  Future<String?> getToken({required String email}) async {
    final result = await _client
        .from('notificationTokens')
        .select('token')
        .eq('email', email)
        .eq('gymId', _gymId)
        .maybeSingle();

    return result?['token'] as String?;
  }

  Future<void> setToken(
      {required String email,
      required String gymId,
      required String token}) async {
    await _client.from('notificationTokens').upsert({
      'email': email,
      'gymId': gymId,
      'token': token,
      'updatedAt': DateTime.now().toIso8601String(),
    }, onConflict: 'email,gymId');
  }
}
