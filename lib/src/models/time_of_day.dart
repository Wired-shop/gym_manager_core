class TimeOfDay {
  final int hour;
  final int minute;

  TimeOfDay({required this.hour, required this.minute}) {
    if (hour < 0 || hour > 23) {
      throw ArgumentError('L\'ora deve essere tra 0 e 23');
    }
    if (minute < 0 || minute > 59) {
      throw ArgumentError('I minuti devono essere tra 0 e 59');
    }
  }

  factory TimeOfDay.fromString(String time) {
    if (time.length > 5) time = time.substring(0, 5);
    final parts = time.split(':');
    if (parts.length != 2) {
      throw FormatException('Formato orario non valido. Utilizzare HH:mm');
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) {
      throw FormatException(
          'Formato orario non valido. Utilizzare numeri per ore e minuti');
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  String format24Hour() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String format12Hour() {
    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  int toMinutes() {
    return hour * 60 + minute;
  }

  bool isAfter(TimeOfDay other) {
    if (hour > other.hour) return true;
    if (hour < other.hour) return false;
    return minute > other.minute;
  }

  bool isBefore(TimeOfDay other) {
    if (hour < other.hour) return true;
    if (hour > other.hour) return false;
    return minute < other.minute;
  }

  TimeOfDay addMinutes(int minutesToAdd) {
    if (minutesToAdd < 0) {
      throw ArgumentError('I minuti da aggiungere devono essere positivi');
    }

    int totalMinutes = hour * 60 + minute + minutesToAdd;
    int newHour = (totalMinutes ~/ 60) % 24;
    int newMinute = totalMinutes % 60;

    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimeOfDay && other.hour == hour && other.minute == minute;
  }

  @override
  int get hashCode => Object.hash(hour, minute);

  @override
  String toString() => format24Hour();
}
