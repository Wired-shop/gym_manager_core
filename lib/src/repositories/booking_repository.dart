import 'package:gym_manager_core/src/enums/booking_result.dart';
import 'package:gym_manager_core/src/enums/booking_status.dart';
import 'package:gym_manager_core/src/models/bookigs.dart';
import 'package:supabase/supabase.dart';

class BookingRepository {
  final SupabaseClient _supabase;

  BookingRepository({required SupabaseClient client}) : _supabase = client;

  Future<List<Booking>> fetchUserBookings({
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
        .select()
        .eq('userId', userId)
        .eq('gymId', gymId)
        .eq('status', BookingStatus.confirmed.toJson())
        .order('shiftDate', ascending: true);

    return (response as List)
        .map((e) => Booking.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<BookingResult> bookShift({
    required String gymId,
    required int shiftId,
    required DateTime shiftDate,
  }) async {
    final String result = await _supabase.rpc(
      'bookShift',
      params: {
        'gymId': gymId,
        'shiftId': shiftId,
        'shiftDate': shiftDate.toIso8601String().split('T').first,
      },
    );

    return switch (result) {
      'ok' => BookingResult.ok,
      'full' => BookingResult.full,
      'alreadyBooked' => BookingResult.alreadyBooked,
      'invalidDate' => BookingResult.invalidDate,
      _ => BookingResult.userNotFound,
    };
  }

  Future<BookingResult> cancelBooking({
    required int bookingId,
  }) async {
    final String result = await _supabase.rpc(
      'cancelBooking',
      params: {
        'bookingId': bookingId,
      },
    );

    return switch (result) {
      'ok' => BookingResult.ok,
      _ => BookingResult.userNotFound,
    };
  }
}
