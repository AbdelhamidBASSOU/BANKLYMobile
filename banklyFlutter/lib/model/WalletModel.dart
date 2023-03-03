import 'package:wallet/model/TransactionModel.dart';

class Wallet {
  final int id;
  final double balance;
  final List<Transaction> transactions;

  Wallet({
    required this.id,
    required this.balance,
    required this.transactions,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    List<Transaction> transactions = [];
    if (json['transactions'] != null) {
      transactions = List<Transaction>.from(
        json['transactions'].map(
          (transactionJson) => Transaction.fromJson(transactionJson),
        ),
      );
    }
    return Wallet(
      id: json['id'],
      balance: json['balance'],
      transactions: transactions,
    );
  }
}
