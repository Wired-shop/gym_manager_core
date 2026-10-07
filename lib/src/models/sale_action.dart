import 'package:gym_manager_core/src/enums/sale_action_type.dart';

class SaleAction {
  final int? id;
  final int saleId;
  final SaleActionType type;

  /// Numero della rata (da 1), solo per le azioni sulle rate
  final int? installmentNumber;
  final int? userId;
  final String? userName;
  final DateTime date;

  SaleAction({
    this.id,
    required this.saleId,
    required this.type,
    this.installmentNumber,
    this.userId,
    this.userName,
    required this.date,
  });

  factory SaleAction.fromJson(Map<String, dynamic> json) {
    return SaleAction(
      id: json['id'] as int?,
      saleId: json['saleId'] as int,
      type: SaleActionType.fromString(json['type'] as String),
      installmentNumber: json['installmentNumber'] as int?,
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'saleId': saleId,
      'type': type.name,
      'installmentNumber': installmentNumber,
      'userId': userId,
      'userName': userName,
      'date': date.toUtc().toIso8601String(),
    };
  }
}
