import 'package:gym_manager_backend/backend.dart';

void main(List<String> arguments) async {
  _listenEntry();
  _listenUsers();
  _insertUser();
}

Future<void> _insertUser() async {
  await Future.delayed(const Duration(seconds: 2));
  print("--------");
  UserRepository.insert(User());
}

_listenEntry() {
  EntryRepository.stream().listen((value) {
    print(value.last.toJson());
  });
}

_listenUsers() {
  UserRepository.stream().listen((value) {
    print(value.map((e) => e.validationResult?.toJson()));
  });
}
