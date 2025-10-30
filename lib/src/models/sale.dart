import 'package:gym_manager_core/core.dart';

class Sale {
  final int? id;
  final DateTime date;
  int userId;
  List<Product> products;
  int? coursePlanId;
  double total;
  PaymentMethod paymentMethod;
  int completed;
  String? note;

  Sale({
    this.id,
    this.coursePlanId,
    this.note,
    required this.completed,
    required this.date,
    required this.userId,
    required this.products,
    required this.total,
    required this.paymentMethod,
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
      coursePlanId: json['coursePlanId'] as int?,
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
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'date': date.toIso8601String(),
        'completed': completed,
        'userId': userId,
        'note': note,
        'products': products.map((e) => e.toJson()).toList(),
        'coursePlanId': coursePlanId,
        'total': total,
        'paymentMethod': paymentMethod.toString().split('.').last,
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
          coursePlanId == other.coursePlanId &&
          total == other.total &&
          paymentMethod == other.paymentMethod;

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      userId.hashCode ^
      products.hashCode ^
      coursePlanId.hashCode ^
      total.hashCode ^
      paymentMethod.hashCode;

  @override
  String toString() => toJson().toString();
}
