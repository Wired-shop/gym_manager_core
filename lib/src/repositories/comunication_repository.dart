import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class ComunicationRepository {
  final SupabaseClient _client;

  ComunicationRepository({required SupabaseClient client}) : _client = client;

  String get _gymId =>
      _client.auth.currentUser?.userMetadata?['gymId'] as String? ?? '';

  Future<Comunication> insert(Comunication comunication) async {
    final data = comunication.toJson()
      ..remove('id')
      ..remove('users')
      ..['gymId'] = _gymId;

    final result =
        await _client.from('comunications').insert(data).select().single();

    final insertedId = result['id'] as int;

    if (comunication.users.isNotEmpty) {
      final usersData = comunication.users
          .map((u) => {...u.toJson(), 'comunicationId': insertedId})
          .toList();
      await _client.from('comunicationUsers').insert(usersData);
    }

    return await get(insertedId);
  }

  Future<Comunication> update(Comunication comunication) async {
    final data = comunication.toJson()
      ..remove('id')
      ..remove('users');

    await _client.from('comunications').update(data).eq('id', comunication.id!);

    await _client
        .from('comunicationUsers')
        .delete()
        .eq('comunicationId', comunication.id!);

    if (comunication.users.isNotEmpty) {
      final usersData = comunication.users
          .map((u) => {...u.toJson(), 'comunicationId': comunication.id!})
          .toList();
      await _client.from('comunicationUsers').insert(usersData);
    }

    return await get(comunication.id!);
  }

  Future<Comunication> get(int id) async {
    final result =
        await _client.from('comunications').select().eq('id', id).single();

    final usersResult = await _client
        .from('comunicationUsers')
        .select()
        .eq('comunicationId', id);

    return Comunication.fromJson({...result, 'users': usersResult});
  }

  Future<List<Comunication>> list({
    String? q,
    String? status,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = _client.from('comunications').select();

    if (q != null && q.trim().isNotEmpty) {
      query = query.ilike('name', '%$q%');
    }
    if (status != null) {
      query = query.eq('status', status);
    }
    if (type != null) {
      query = query.eq('type', type);
    }
    if (startDate != null) {
      query = query.gte('scheduledAt', startDate.toIso8601String());
    }
    if (endDate != null) {
      final end =
          DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
      query = query.lte('scheduledAt', end.toIso8601String());
    }

    final results = await query.order('scheduledAt', ascending: false);

    final List<Comunication> comunications = [];
    for (final row in results as List) {
      final id = row['id'] as int;
      comunications.add(await get(id));
    }
    return comunications;
  }

  Future<void> delete(int id) async {
    await _client.from('comunications').delete().eq('id', id);
  }
}
