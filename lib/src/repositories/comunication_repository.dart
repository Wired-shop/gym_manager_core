import 'dart:typed_data';

import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class ComunicationRepository {
  final SupabaseClient _client;
  static const _attachmentsBucket = 'attachments';

  ComunicationRepository({required SupabaseClient client}) : _client = client;

  String get _gymId =>
      _client.auth.currentUser?.appMetadata['gymId'] as String? ?? '';

  Future<String> _uploadAttachment({
    required Uint8List bytes,
    required String fileName,
    String? contentType,
  }) async {
    final path = '${DateTime.now().millisecondsSinceEpoch}_$fileName';

    await _client.storage.from(_attachmentsBucket).uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: contentType, upsert: false),
        );

    return _client.storage.from(_attachmentsBucket).getPublicUrl(path);
  }

  Future<void> _deleteAttachment(String attachmentUrl) async {
    final marker = '/object/public/$_attachmentsBucket/';
    final idx = attachmentUrl.indexOf(marker);
    if (idx == -1) return;
    final path = attachmentUrl.substring(idx + marker.length);
    await _client.storage.from(_attachmentsBucket).remove([path]);
  }

  Future<Comunication> insert(
    Comunication comunication, {
    Uint8List? attachmentBytes,
    String? attachmentFileName,
    String? attachmentContentType,
  }) async {
    var attachmentUrl = comunication.attachmentUrl;
    if (attachmentBytes != null && attachmentFileName != null) {
      attachmentUrl = await _uploadAttachment(
        bytes: attachmentBytes,
        fileName: attachmentFileName,
        contentType: attachmentContentType,
      );
    }

    final data = comunication.toJson()
      ..remove('id')
      ..remove('users');
    data['gymId'] = _gymId;
    data['attachmentUrl'] = attachmentUrl;

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

  Future<Comunication> update(
    Comunication comunication, {
    Uint8List? attachmentBytes,
    String? attachmentFileName,
    String? attachmentContentType,
    bool removeAttachment = false,
  }) async {
    var attachmentUrl = comunication.attachmentUrl;

    if (attachmentBytes != null && attachmentFileName != null) {
      if (attachmentUrl != null) {
        await _deleteAttachment(attachmentUrl);
      }
      attachmentUrl = await _uploadAttachment(
        bytes: attachmentBytes,
        fileName: attachmentFileName,
        contentType: attachmentContentType,
      );
    } else if (removeAttachment && attachmentUrl != null) {
      await _deleteAttachment(attachmentUrl);
      attachmentUrl = null;
    }

    final data = comunication.toJson()
      ..remove('id')
      ..remove('users');
    data['gymId'] = _gymId;
    data['attachmentUrl'] = attachmentUrl;

    await _client
        .from('comunications')
        .update(data)
        .eq('id', comunication.id!)
        .eq('gymId', _gymId);

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
    final result = await _client
        .from('comunications')
        .select()
        .eq('id', id)
        .eq('gymId', _gymId)
        .single();

    final usersResult = await _client
        .from('comunicationUsers')
        .select()
        .eq('comunicationId', id);

    return Comunication.fromJson({...result, 'users': usersResult});
  }

  Future<List<Comunication>> list({
    String? q,
    ComunicationStatus? status,
    ComunicationChannel? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = _client.from('comunications').select().eq('gymId', _gymId);

    if (q != null && q.trim().isNotEmpty) {
      query = query.ilike('name', '%$q%');
    }
    if (status != null) {
      query = query.eq('status', status.name);
    }
    if (type != null) {
      query = query.eq('type', type.name);
    }
    if (startDate != null) {
      query = query.gte('scheduledAt', startDate.toIso8601String());
    }
    if (endDate != null) {
      final end =
          DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
      query = query.lte('scheduledAt', end.toIso8601String());
    }

    final results = await query.order('createdAt', ascending: false);

    final List<Comunication> comunications = [];
    for (final row in results as List) {
      final id = row['id'] as int;
      comunications.add(await get(id));
    }
    return comunications;
  }

  Future<void> delete(int id) async {
    final comunication = await get(id);
    if (comunication.attachmentUrl != null) {
      await _deleteAttachment(comunication.attachmentUrl!);
    }

    await _client
        .from('comunications')
        .delete()
        .eq('id', id)
        .eq('gymId', _gymId);
  }

  RealtimeChannel stream(void Function() onChange) {
    return _client
        .channel('comunications-changes-$_gymId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'comunications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'gymId',
            value: _gymId,
          ),
          callback: (_) => onChange(),
        )
        .subscribe();
  }
}
