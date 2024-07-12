import 'package:gym_manager_backend/backend.dart';

void main(List<String> arguments) async {
  _listenEntry();

  _listenUsers();

  await Future.delayed(const Duration(seconds: 2));
  print("--------");
  EntryRepository.insert(
    Entry(
        userId: 3,
        subscriptionId: 2,
        date: DateTime.now(),
        response: EntryResponse.valid),
  );
}

_listenEntry() {
  EntryRepository.stream().listen((value) {
    print(value.map((e) => e.toJson()));
  });
}

_listenUsers() {
  UserRepository.stream().listen((value) {
    print(value.map((e) => e.validationResult?.toJson()));
  });
}
