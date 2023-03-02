import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Wallet.dart';

class WalletService {
  final String baseUrl = 'http://localhost:8089/api/wallet/Wallet/';

  Future<Wallet> getWalletById(int id) async {
    final response = await http.get(Uri.parse(baseUrl + id.toString()));
    if (response.statusCode == 200) {
      return Wallet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load wallet');
    }
  }

  Future<Wallet> updateWalletBalance(int id, double newBalance) async {
    final response = await http.put(
      Uri.parse(baseUrl + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'balance': newBalance,
      }),
    );
    if (response.statusCode == 200) {
      return Wallet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update wallet balance');
    }
  }
}
