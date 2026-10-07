import 'package:gym_manager_core/src/models/sale_action.dart';

class SaleJournal {
  final int saleId;
  final List<SaleAction> actions;

  SaleJournal({
    required this.saleId,
    required this.actions,
  });

  factory SaleJournal.fromJson(Map<String, dynamic> json) {
    return SaleJournal(
      saleId: json['saleId'] as int,
      actions: (json['actions'] as List<dynamic>? ?? [])
          .map((e) => SaleAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'saleId': saleId,
      'actions': actions.map((e) => e.toJson()).toList(),
    };
  }
}
