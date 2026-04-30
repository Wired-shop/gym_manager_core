import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

Future<void> main(List<String> arguments) async {
  const String supabaseUrl = "https://vmtsftgetmujafzznzdr.supabase.co";
  const String supabaseAnonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtdHNmdGdldG11amFmenpuemRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE2MDAxMjgsImV4cCI6MjA4NzE3NjEyOH0.vJN4z48Y4qTuDCJ9BQWUYJxvtMOQwOZ9ODju9vhIhcA";

  SupabaseClient supabaseClient = SupabaseClient(supabaseUrl, supabaseAnonKey);
  await supabaseClient.auth.signInWithPassword(
      password: "PATRIC-DYXQ-WWVK", email: "patrickgym@gmail.com");

  BookingRepository bookingRepository =
      BookingRepository(client: supabaseClient);
  bookingRepository
      .list(gymId: "patrickgym", courseId: 3)
      .then((value) => print(value.map((b) => b.toJson())));
}
