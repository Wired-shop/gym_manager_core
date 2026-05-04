import 'package:gym_manager_core/core.dart';

class ShiftWithAvailability {
  final Shift shift;
  final int occupiedSeats;

  ShiftWithAvailability({
    required this.shift,
    required this.occupiedSeats,
  });

  int get availableSeats =>
      ((shift.maxSeats ?? 0) - occupiedSeats).clamp(0, shift.maxSeats ?? 0);

  bool get isFull => shift.maxSeats != null && occupiedSeats >= shift.maxSeats!;

  double get progress => shift.maxSeats != null && shift.maxSeats! > 0
      ? (occupiedSeats / shift.maxSeats!).clamp(0.0, 1.0)
      : 0.0;
}
