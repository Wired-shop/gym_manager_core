import 'package:gym_manager_core/core.dart';

class Sale {
  final int? id;
  final DateTime date;
  int userId;
  List<Product> products;
  int? planId;
  double total;
  PaymentMethod paymentMethod;
  int completed;
  String? note;
  List<SaleInstallment> installments;
  int installmentsEnabled;

  Sale({
    this.id,
    this.planId,
    this.note,
    required this.completed,
    required this.date,
    required this.userId,
    required this.products,
    required this.total,
    required this.paymentMethod,
    required this.installments,
    required this.installmentsEnabled,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'] as int?,
      date: DateTime.parse(json['date'] as String),
      userId: json['userId'] as int,
      products: json['products'] != null
          ? (json['products'] as List)
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      planId: json['planId'] as int?,
      total: json['total'] is String
          ? double.parse(json['total'])
          : (json['total'] as num).toDouble(),
      completed: (json['completed'] as int),
      note: (json['note'] as String?),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) =>
            e.toString().split('.').last == (json['paymentMethod'] as String),
        orElse: () => PaymentMethod.cash,
      ),
      installments: json['installments'] != null
          ? (json['installments'] as List)
              .map((e) => SaleInstallment.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      installmentsEnabled: json['installmentsEnabled'] != null
          ? json['installmentsEnabled'] as int
          : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'date': date.toIso8601String(),
        'completed': completed,
        'userId': userId,
        'note': note,
        'products': products.map((e) => e.toJson()).toList(),
        'planId': planId,
        'total': total,
        'paymentMethod': paymentMethod.toString().split('.').last,
        'installments': installments.map((e) => e.toJson()).toList(),
        'installmentsEnabled': installmentsEnabled,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sale &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          userId == other.userId &&
          products == other.products &&
          planId == other.planId &&
          total == other.total &&
          paymentMethod == other.paymentMethod &&
          installments == other.installments &&
          installmentsEnabled == other.installmentsEnabled;

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      userId.hashCode ^
      products.hashCode ^
      planId.hashCode ^
      total.hashCode ^
      paymentMethod.hashCode ^
      installments.hashCode ^
      installmentsEnabled.hashCode;

  @override
  String toString() => toJson().toString();
}
