import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class CampaignRepository {
  final SupabaseClient _client;

  CampaignRepository({required SupabaseClient client}) : _client = client;

  Future<Campaign> insert(Campaign campaign) async {
    final data = campaign.toJson()
      ..remove('id')
      ..remove('users');

    final result =
        await _client.from('campaigns').insert(data).select().single();

    final insertedId = result['id'] as int;

    if (campaign.users.isNotEmpty) {
      final usersData = campaign.users
          .map((u) => {...u.toJson(), 'campaignId': insertedId})
          .toList();
      await _client.from('campaignUsers').insert(usersData);
    }

    return await get(insertedId);
  }

  Future<Campaign> update(Campaign campaign) async {
    final data = campaign.toJson()
      ..remove('id')
      ..remove('users');

    await _client.from('campaigns').update(data).eq('id', campaign.id!);

    await _client.from('campaignUsers').delete().eq('campaignId', campaign.id!);

    if (campaign.users.isNotEmpty) {
      final usersData = campaign.users
          .map((u) => {...u.toJson(), 'campaignId': campaign.id!})
          .toList();
      await _client.from('campaignUsers').insert(usersData);
    }

    return await get(campaign.id!);
  }

  Future<Campaign> get(int id) async {
    final result =
        await _client.from('campaigns').select().eq('id', id).single();

    final usersResult =
        await _client.from('campaignUsers').select().eq('campaignId', id);

    final users = (usersResult as List)
        .map((e) => CampaignUser.fromJson(e as Map<String, dynamic>))
        .toList();

    return Campaign.fromJson({...result, 'users': users});
  }

  Future<List<Campaign>> list({
    String? q,
    String? status,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = _client.from('campaigns').select();

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

    final List<Campaign> campaigns = [];
    for (final row in results as List) {
      final id = row['id'] as int;
      campaigns.add(await get(id));
    }
    return campaigns;
  }

  Future<void> delete(int id) async {
    await _client.from('campaigns').delete().eq('id', id);
  }
}
