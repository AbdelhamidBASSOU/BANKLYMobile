import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'wallet_home.dart';
class WalletTransactionPage extends StatefulWidget {
  final double balance;

  const WalletTransactionPage({Key? key, required this.balance}) : super(key: key);

  @override
  _WalletTransactionPageState createState() => _WalletTransactionPageState();
}

class _WalletTransactionPageState extends State<WalletTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  bool _isDeposit = true;

  Future<void> _deposit() async {
    String url = 'http://172.16.10.205:8089/api/transaction/credit';
    double amount = double.parse(_amountController.text);
    final response = await http.post(Uri.parse(url), body: {
      'walletId': '1', // Replace with the actual wallet ID
      'amount': amount.toStringAsFixed(2),
    });
    if (response.statusCode == 200) {
      // Success
      print(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WalletHomePage()),
      );
    } else {
      // Error
      print(response.reasonPhrase);
    }
  }

  Future<void> _withdraw() async {
    String url = 'http://172.16.10.205:8089/api/transaction/debit';
    double amount = double.parse(_amountController.text);
    final response = await http.post(Uri.parse(url), body: {
      'walletId': '1', // Replace with the actual wallet ID
      'amount': amount.toStringAsFixed(2),
    });
    if (response.statusCode == 200) {
      // Success
      print(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WalletHomePage()),
      );
    } else {
      // Error
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Transaction Type',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Deposit',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: true,
                    groupValue: _isDeposit,
                    onChanged: (value) {
                      setState(() {
                        _isDeposit = value as bool;
                      });
                    },
                  ),
                  Text(
                    'Withdrawal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: false,
                    groupValue: _isDeposit,
                    onChanged: (value) {
                      setState(() {
                        _isDeposit = value as bool;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Amount',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _isDeposit ? _deposit : _withdraw,
                    child: Text(_isDeposit ? 'Deposit' : 'Withdraw'),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
