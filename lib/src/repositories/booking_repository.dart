import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

class BookingRepository {
  static late SupabaseClient _supabase;

  static init(SupabaseClient client) {
    _supabase = client;
  }

  static String get _gymId =>
      _supabase.auth.currentUser?.userMetadata?['gymId'] as String? ?? '';
  static String get _email => _supabase.auth.currentUser?.email ?? '';

  static Future<ShiftWithAvailability> fetchShiftAvailability({
    required Shift shift,
  }) async {
    final response = await _supabase
        .from('bookings')
        .select('id')
        .eq('gymId', _gymId)
        .eq('shiftId', shift.id!)
        .eq('shiftDate',
            shift.nextOccurrence.toIso8601String().split('T').first)
        .eq('status', BookingStatus.confirmed.toJson())
        .count();

    return ShiftWithAvailability(
      shift: shift,
      occupiedSeats: response.count,
    );
  }

  static Future<List<Booking>> fetchUserBookings() async {
    final userResponse = await _supabase
        .from('users')
        .select('id')
        .eq('email', _email)
        .eq('gymId', _gymId)
        .maybeSingle();
    if (userResponse == null) {
      throw Exception("Nessun utente trovato. Contatta la struttura.");
    }
    final userId = userResponse['id'] as int;
    final response = await _supabase
        .from('bookings')
        .select('*, shifts(courseId)')
        .eq('userId', userId)
        .eq('gymId', _gymId)
        .eq('status', BookingStatus.confirmed.toJson())
        .order('shiftDate', ascending: true);
    return (response as List)
        .map((e) => Booking.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<BookingResult> bookShift({
    required int shiftId,
    required DateTime shiftDate,
    int? userId,
  }) async {
    final params = {
      'pGymId': _gymId,
      'pShiftId': shiftId,
      'pShiftDate': shiftDate.toIso8601String().split('T').first,
    };

    if (userId != null) {
      params['pUserId'] = userId;
    }

    final String result = await _supabase.rpc(
      'bookShift',
      params: params,
    );

    return switch (result) {
      'ok' => BookingResult.ok,
      'full' => BookingResult.full,
      'alreadyBooked' => BookingResult.alreadyBooked,
      'invalidDate' => BookingResult.invalidDate,
      'unauthorized' => BookingResult.unauthorized, // ← nuovo
      _ => BookingResult.userNotFound,
    };
  }

  static Future<BookingResult> cancelBooking({required int bookingId}) async {
    final String result = await _supabase.rpc(
      'cancelBooking',
      params: {'bookingId': bookingId},
    );
    return switch (result) {
      'ok' => BookingResult.ok,
      _ => BookingResult.userNotFound,
    };
  }

  static Future<List<Booking>> list({
    required int courseId,
    int? shiftId,
  }) async {
    final shiftIds = await _supabase
        .from('shifts')
        .select('id')
        .eq('gymId', _gymId)
        .eq('courseId', courseId);
    final ids = (shiftIds as List).map((s) => s['id'] as int).toList();
    if (ids.isEmpty) return [];
    final response = await _supabase
        .from('bookings')
        .select('*, shifts(courseId), users(id, name, surname, email)')
        .eq('gymId', _gymId)
        .inFilter('shiftId', shiftId != null ? [shiftId] : ids)
        .order('shiftDate', ascending: false);
    return (response as List)
        .map((e) => Booking.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> markAsUsed({required int bookingId}) async {
    await _supabase
        .from('bookings')
        .update({'status': BookingStatus.used.toJson()}).eq('id', bookingId);
  }
}
