class Transaction {
  final int id;
  final DateTime date;
  final double amount;
  final Type type;
  final int walletId;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.walletId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
      type: json['type'],
      walletId: json['walletId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'type': type.toString().split('.').last,
      'walletId': walletId,
    };
  }
}
