import 'package:gym_manager_core/core.dart';

Future<void> main(List<String> arguments) async {
  var localhost = "127.0.0.1";

  ApiService.getInstance().setIP(localhost);
  ApiService.getInstance().setPORT(3000);

  var email = "pleiadisem@gmail.com";
  ApiService.getInstance().setEmail(email);

  // 🔹 1. Recuperiamo due prodotti esistenti dal database
  List<Product>? p1 =
      await ProductRepository.insert([Product(name: "c", price: 12)]);

  if (p1.isEmpty) {
    print("❌ Uno dei prodotti non esiste, verifica gli ID nel DB.");
    return;
  }

  // 🔹 2. Creiamo la vendita con i prodotti
  Sale newSale = Sale(
    date: DateTime.now(),
    userId: 940, // ID utente registrato nel DB
    products: [p1.first, p1.first, p1.first],
    coursePlanId: null, // Nessun piano corso collegato
    total: p1.first.price * 4,
    paymentMethod: PaymentMethod.cash,
    completed: 1,
    note: "Vendita test di due prodotti",
  );

  // 🔹 3. Inseriamo la vendita nel backend
  Sale insertedSale = await SaleRepository.insert(newSale);

  // 🔹 4. Mostriamo il risultato
  print("✅ Vendita inserita con successo!");
  print("ID vendita: ${insertedSale.id}");
  print("Totale: €${insertedSale.total}");
  print("Prodotti associati:");
  for (var product in insertedSale.products) {
    print(" - ${product.name} (€${product.price})");
  }

  // 🔹 5. Recuperiamo la vendita per verificarla
  Sale? fetchedSale = await SaleRepository.get(insertedSale.id!);
  print("\n📦 Vendita recuperata dal server:");
  print(fetchedSale?.toJson());
}
