import 'package:gym_manager_core/core.dart';

class Sale {
  final int? id;
  final DateTime saleDate;
  final int userId;
  final List<Product> products;
  final CoursePlan? coursePlan;
  final double total;
  final PaymentMethod paymentMethod;

  Sale({
    this.id,
    required this.saleDate,
    required this.userId,
    required this.products,
    this.coursePlan,
    required this.total,
    required this.paymentMethod,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'] as int?,
      saleDate: DateTime.parse(json['saleDate'] as String),
      userId: json['userId'] as int,
      products: (json['products'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      coursePlan: json['coursePlan'] != null
          ? CoursePlan.fromJson(json['coursePlan'] as Map<String, dynamic>)
          : null,
      total: json['total'] is String
          ? double.parse(json['total'])
          : (json['total'] as num).toDouble(),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) =>
            e.toString().split('.').last == (json['paymentMethod'] as String),
        orElse: () => PaymentMethod.cash,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'saleDate': saleDate.toIso8601String(),
        'userId': userId,
        'products': products.map((e) => e.toJson()).toList(),
        if (coursePlan != null) 'coursePlan': coursePlan!.toJson(),
        'total': total,
        'paymentMethod': paymentMethod.toString().split('.').last,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sale &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          saleDate == other.saleDate &&
          userId == other.userId &&
          products == other.products &&
          coursePlan == other.coursePlan &&
          total == other.total &&
          paymentMethod == other.paymentMethod;

  @override
  int get hashCode =>
      id.hashCode ^
      saleDate.hashCode ^
      userId.hashCode ^
      products.hashCode ^
      coursePlan.hashCode ^
      total.hashCode ^
      paymentMethod.hashCode;

  @override
  String toString() => toJson().toString();
}
