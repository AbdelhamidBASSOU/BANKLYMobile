import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/WalletModel.dart';

class WalletService {
  final String baseUrl = 'http://localhost:8089/api/wallet/';

  Future<double> getBalance(int id) async {
    final wallet = await getWalletById(id);
    return wallet.balance;
  }

  Future<Wallet> getWalletById(int id) async {
    final response = await http.get(Uri.parse(baseUrl + id.toString()));
    if (response.statusCode == 200) {
      return Wallet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load wallet');
    }
  }

}
