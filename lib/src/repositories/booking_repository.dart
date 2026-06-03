import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class BookingRepository {
  final SupabaseClient _client;

  BookingRepository({required SupabaseClient client}) : _client = client;

  String get _gymId =>
      _client.auth.currentUser?.userMetadata?['gymId'] as String? ?? '';

  String get _email => _client.auth.currentUser?.email ?? '';

  Future<ShiftWithAvailability> fetchShiftAvailability({
    required Shift shift,
  }) async {
    final response = await _client
        .from('bookings')
        .select('id')
        .eq('gymId', _gymId)
        .eq('shiftId', shift.id!)
        .eq('shiftDateTime', shift.nextBookableOccurrence.toIso8601String())
        .eq('status', BookingStatus.confirmed.toJson())
        .count();

    return ShiftWithAvailability(
      shift: shift,
      occupiedSeats: response.count,
    );
  }

  Future<List<Booking>> fetchUserBookings({bool onlyFuture = true}) async {
    final userResponse = await _client
        .from('users')
        .select('id')
        .eq('email', _email)
        .eq('gymId', _gymId)
        .maybeSingle();

    if (userResponse == null) {
      throw Exception("Nessun utente trovato. Contatta la struttura.");
    }

    final userId = userResponse['id'] as int;

    var query = _client
        .from('bookings')
        .select('*, shifts(courseId)')
        .eq('userId', userId)
        .eq('gymId', _gymId)
        .eq('status', BookingStatus.confirmed.toJson());

    if (onlyFuture) {
      query = query.gte('shiftDateTime', DateTime.now().toIso8601String());
    }

    final response = await query.order('shiftDateTime', ascending: true);

    return (response as List)
        .map((e) => Booking.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<BookingResult> bookShift({
    required int shiftId,
    required DateTime shiftDate,
    int? userId,
  }) async {
    final params = {
      'pGymId': _gymId,
      'pShiftId': shiftId,
      'pShiftDateTime': shiftDate.toIso8601String(),
    };

    if (userId != null) {
      params['pUserId'] = userId;
    }

    final String result = await _client.rpc('bookShift', params: params);

    return switch (result) {
      'ok' => BookingResult.ok,
      'full' => BookingResult.full,
      'alreadyBooked' => BookingResult.alreadyBooked,
      'invalidDate' => BookingResult.invalidDate,
      'unauthorized' => BookingResult.unauthorized,
      _ => BookingResult.userNotFound,
    };
  }

  Future<BookingResult> cancelBooking({required int bookingId}) async {
    final String result = await _client.rpc(
      'cancelBooking',
      params: {'bookingId': bookingId},
    );

    return switch (result) {
      'ok' => BookingResult.ok,
      _ => BookingResult.userNotFound,
    };
  }

  Future<List<Booking>> list({
    required int courseId,
    int? shiftId,
  }) async {
    final shiftIds = await _client
        .from('shifts')
        .select('id')
        .eq('gymId', _gymId)
        .eq('courseId', courseId);

    final ids = (shiftIds as List).map((s) => s['id'] as int).toList();
    if (ids.isEmpty) return [];

    final response = await _client
        .from('bookings')
        .select('*, shifts(courseId), users(id, name, surname, email)')
        .eq('gymId', _gymId)
        .inFilter('shiftId', shiftId != null ? [shiftId] : ids)
        .order('shiftDateTime', ascending: false);

    return (response as List)
        .map((e) => Booking.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> markAsUsed({required int bookingId}) async {
    await _client
        .from('bookings')
        .update({'status': BookingStatus.used.toJson()}).eq('id', bookingId);
  }
}
