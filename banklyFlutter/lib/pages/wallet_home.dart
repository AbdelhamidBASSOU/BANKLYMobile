import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallet/pages/wallet_transaction.dart';
import 'package:http/http.dart' as http;

import '../service/WalletService.dart';

class WalletHomePage extends StatefulWidget {
  @override
  _WalletHomePageState createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  double _balance = 0.0;
  dynamic _wallet;
  int idWallet = 1;

  @override
  void initState() {
    super.initState();
    _fetchWallet(idWallet);
  }
  Future<void> _fetchWallet(int idWallet) async {
    String url = 'http://172.16.10.205:8089/api/wallet/Wallet/$idWallet';
    http.get(Uri.parse(url)).then((response) {
      print(response.body);
      setState(() {
        _wallet = json.decode(response.body);
      });
    }).catchError((err){
      print(err);
    });
  }

  Future<void> _navigateToTransactionPage() async {
    final updatedBalance = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalletTransactionPage(balance: _balance),
      ),
    );
    if (updatedBalance != null) {
      setState(() {
        _balance = updatedBalance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Balance',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              "\$ ${(_wallet == null)?'':_wallet['balance']}",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _navigateToTransactionPage,
              child: Text('Make a Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
