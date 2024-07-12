import 'package:gym_manager_backend/backend.dart';

void main(List<String> arguments) {
  _listenEntry();
  _listenUsers();
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
