import 'package:flutter/material.dart';

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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        double amount = double.parse(_amountController.text);
                        double updatedBalance =
                        _isDeposit ? widget.balance + amount : widget.balance - amount;
                        Navigator.pop(context, updatedBalance);
                      }
                    },
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
