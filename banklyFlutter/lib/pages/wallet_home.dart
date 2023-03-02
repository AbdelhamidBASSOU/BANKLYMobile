import 'package:flutter/material.dart';
import 'package:wallet/pages/wallet_transaction.dart';


class WalletHomePage extends StatefulWidget {
  @override
  _WalletHomePageState createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  double _balance = 100.0;

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
              '\$ $_balance',
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