import 'package:gym_manager_core/core.dart';

void main(List<String> arguments) async {
  ApiService.getInstance().setGymId("1");
  ApiService.getInstance().setIP("127.0.0.1");
  ApiService.getInstance().setPORT(3000);

  User? user = await UserRepository.get(id: 10);
  print(user);

  user?.medicalCertificateExpiration = DateTime.now();
  await UserRepository.update(user: user!);

  user = await UserRepository.get(id: 10);
  print(user);
}
