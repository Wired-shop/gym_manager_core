class SaleInstallment {
  final int? id;
  double total;
  DateTime expiration;
  String? note;
  int completed;

  SaleInstallment({
    this.id,
    this.note,
    required this.total,
    required this.expiration,
    required this.completed,
  });

  factory SaleInstallment.fromJson(Map<String, dynamic> json) {
    return SaleInstallment(
      id: json['id'] as int?,
      total: json['total'] is String
          ? double.parse(json['total'])
          : (json['total'] as num).toDouble(),
      expiration: DateTime.parse(json['expiration'] as String),
      note: json['note'] as String?,
      completed: json['completed'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'total': total,
        'expiration': expiration.toIso8601String(),
        'note': note,
        'completed': completed,
      };

  static List<SaleInstallment> generateSplit({
    required double total,
    required int count,
    required DateTime startDate,
  }) {
    if (count <= 0) return [];

    final baseAmount = (total / count * 100).floor() / 100;
    final installments = <SaleInstallment>[];

    for (var i = 0; i < count; i++) {
      final isLast = i == count - 1;
      final amount = isLast
          ? double.parse((total - baseAmount * (count - 1)).toStringAsFixed(2))
          : baseAmount;

      installments.add(SaleInstallment(
        total: amount,
        expiration:
            DateTime(startDate.year, startDate.month + i + 1, startDate.day),
        completed: 0,
      ));
    }

    return installments;
  }

  static int computeStatus(List<SaleInstallment> installments) {
    if (installments.isEmpty) return 0;

    final completedCount = installments.where((i) => i.completed == 1).length;
    if (completedCount == 0) return 0;
    if (completedCount == installments.length) return 1;
    return 2;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleInstallment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          total == other.total &&
          expiration == other.expiration &&
          note == other.note &&
          completed == other.completed;

  @override
  int get hashCode =>
      id.hashCode ^
      total.hashCode ^
      expiration.hashCode ^
      note.hashCode ^
      completed.hashCode;

  @override
  String toString() => toJson().toString();
}
