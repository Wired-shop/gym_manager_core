import 'package:gym_manager_core/src/enums/booking_result.dart';
import 'package:gym_manager_core/src/enums/booking_status.dart';
import 'package:gym_manager_core/src/models/booking.dart';
import 'package:supabase/supabase.dart';

class BookingRepository {
  static late SupabaseClient _supabase;

  static init(SupabaseClient client) {
    _supabase = client;
  }

  static Future<List<Booking>> fetchUserBookings({
    required String email,
    required String gymId,
  }) async {
    final userResponse = await _supabase
        .from('users')
        .select('id')
        .eq('email', email)
        .eq('gymId', gymId)
        .maybeSingle();
    if (userResponse == null) {
      throw Exception("Nessun utente trovato. Contatta la struttura.");
    }
    final userId = userResponse['id'] as int;
    final response = await _supabase
        .from('bookings')
        .select('*, shifts(courseId)')
        .eq('userId', userId)
        .eq('gymId', gymId)
        .eq('status', BookingStatus.confirmed.toJson())
        .order('shiftDate', ascending: true);
    return (response as List)
        .map((e) => Booking.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<BookingResult> bookShift({
    required String gymId,
    required int shiftId,
    required DateTime shiftDate,
    int? userId, // ← da required a opzionale
  }) async {
    final params = {
      'pGymId': gymId,
      'pShiftId': shiftId,
      'pShiftDate': shiftDate.toIso8601String().split('T').first,
    };

    // aggiunge pUserId solo se passato (app admin)
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
    required String gymId,
    required int courseId,
    int? shiftId,
  }) async {
    final shiftIds = await _supabase
        .from('shifts')
        .select('id')
        .eq('gymId', gymId)
        .eq('courseId', courseId);
    final ids = (shiftIds as List).map((s) => s['id'] as int).toList();
    if (ids.isEmpty) return [];
    final response = await _supabase
        .from('bookings')
        .select('*, shifts(courseId), users(id, name, surname, email)')
        .eq('gymId', gymId)
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

  static Future<void> cancel({required int bookingId}) async {
    await _supabase.from('bookings').update(
        {'status': BookingStatus.cancelled.toJson()}).eq('id', bookingId);
  }
}
