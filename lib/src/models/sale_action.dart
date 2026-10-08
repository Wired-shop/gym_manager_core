import 'package:gym_manager_core/src/enums/sale_action_type.dart';

class SaleAction {
  final int? id;
  final int saleId;
  final SaleActionType type;
  final int? installmentId;
  final int? sellerId;
  final String? sellerName;
  final DateTime date;

  SaleAction({
    this.id,
    required this.saleId,
    required this.type,
    this.installmentId,
    this.sellerId,
    this.sellerName,
    required this.date,
  });

  factory SaleAction.fromJson(Map<String, dynamic> json) {
    return SaleAction(
      id: json['id'] as int?,
      saleId: json['saleId'] as int,
      type: SaleActionType.fromString(json['type'] as String),
      installmentId: json['installmentId'] as int?,
      sellerId: json['sellerId'] as int?,
      sellerName: json['sellerName'] as String?,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'saleId': saleId,
      'type': type.name,
      'installmentId': installmentId,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'date': date.toUtc().toIso8601String(),
    };
  }
}
