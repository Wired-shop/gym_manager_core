import 'package:gym_manager_core/core.dart';
import 'package:supabase/supabase.dart';

Future<void> main(List<String> arguments) async {
  UserRepository.get(609).then((user) async => print(Validator.validate(
          user: user!,
          subscription: await SubscriptionRepository.get(userId: 609))
      .toJson()));
}
