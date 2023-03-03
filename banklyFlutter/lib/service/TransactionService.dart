import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/TransactionModel.dart';

class TransactionService {
  final String baseUrl = 'http://localhost:8089/api/transaction';

  Future<Transaction> credit(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/credit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction.toJson()),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to credit transaction');
    }
  }

  Future<Transaction> debit(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/debit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction.toJson()),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to debit transaction');
    }
  }
}
