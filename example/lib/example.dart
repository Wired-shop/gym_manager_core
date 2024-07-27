import 'package:gym_manager_backend/backend.dart';

void main(List<String> arguments) async {
  //editUser(362);
  //listenEntry();
  //listenUsers();
  //insertUser();
  print(
    await listUsers(UsersFilter()),
  );
}

Future<void> editUser(int id) async {
  print("--------");
  UserRepository.update(
    User.fromJson(
      {
        "id": 362,
        "name": "Ciccione",
        "surname": "Pasticcione",
        "birthday": "2024-01-12T00:00:00.000",
        "gender": null,
        "address": null,
        "fiscalCode": null,
        "city": "Biancavilla",
        "zipCode": 95033,
        "province": "CT",
        "phone": null,
        "phone2": null,
        "phone2Type": null,
        "phone3": null,
        "phone3Type": null,
        "email": "patricknicolosi99@gmail.com",
        "privateNote": null,
        "publicNote": null,
        "subscriptionExpiration": null,
        "affiliationExpiration": null,
        "medicalCertificateExpiration": null,
        "image": null,
        "medicalDocument": null,
        "affiliationDocument": null,
        "subscriptionDocument": null,
        "flagged": null,
        "tpPro": null,
        "validationResult": {
          "response": "notValid",
          "warnings": [
            "abbonamentoScaduto",
            "certificatoMedicoAssente",
            "affiliazioneAssente",
            "iscrizioneAssente"
          ]
        }
      },
    ),
  );
}

Future<void> insertUser() async {
  await Future.delayed(const Duration(seconds: 2));
  print("--------");
  UserRepository.insert(User());
}

listenEntry() {
  EntryRepository.stream().listen((value) {
    print(value.last.toJson());
  });
}

listenUsers() {
  UserRepository.stream().listen((value) {
    print(value.map((e) => e.validationResult?.toJson()));
  });
}

Future<List<User>> listUsers(UsersFilter filter) async {
  return await UserRepository.list(filter: filter);
}
