import 'package:flutter/material.dart';
import 'dart:math';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final _formKey = GlobalKey<FormState>();
  double? _loanAmount;
  double? _interestRate;
  int? _loanTerm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Magic Loan Calculator',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Playful Header
                Center(
                  child: Text(
                    "Let's Calculate Your Loan!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildInputField(
                  label: 'Loan Amount 💰',
                  hint: 'Enter the loan amount',
                  onSave: (value) => _loanAmount = double.tryParse(value!),
                ),
                _buildInputField(
                  label: 'Interest Rate (%) 🌟',
                  hint: 'Enter the interest rate',
                  onSave: (value) => _interestRate = double.tryParse(value!),
                ),
                _buildInputField(
                  label: 'Loan Term (Months) 📅',
                  hint: 'Enter the loan term',
                  onSave: (value) => _loanTerm = int.tryParse(value!),
                ),
                const SizedBox(height: 20),
                // Fun Calculate Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      double monthlyPayment = _calculateMonthlyPayment();
                      _showResultDialog(monthlyPayment);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    '🎉 Calculate Now 🎉',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required Function(String?) onSave,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.purple),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
          onSaved: onSave,
        ),
      ),
    );
  }

  double _calculateMonthlyPayment() {
    if (_loanAmount == null || _interestRate == null || _loanTerm == null) {
      return 0.0;
    }
    double monthlyInterestRate = _interestRate! / 100 / 12;
    int totalPayments = _loanTerm!;
    return (_loanAmount! * monthlyInterestRate) /
        (1 - pow(1 + monthlyInterestRate, -totalPayments));
  }

  void _showResultDialog(double monthlyPayment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.purple[50],
          title: Center(
            child: Text(
              'Your Magic Payment 🎩',
              style: TextStyle(fontSize: 24, color: Colors.purple),
            ),
          ),
          content: Text(
            '✨ Your monthly payment is: \n💵 \$${monthlyPayment.toStringAsFixed(2)} 💵',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Yay!'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              ),
            ),
          ],
        );
      },
    );
  }
}
