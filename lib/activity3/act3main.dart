import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiddo Investment Simulator',
      home: InvestmentSimulator(),
    );
  }
}

class InvestmentSimulator extends StatefulWidget {
  @override
  _InvestmentSimulatorState createState() => _InvestmentSimulatorState();
}

class _InvestmentSimulatorState extends State<InvestmentSimulator> {
  double _initialInvestment = 1000.0;
  double _annualReturnRate = 0.07;
  int _investmentYears = 5;
  double _currentInvestmentValue = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateInvestmentValue();
  }

  void _calculateInvestmentValue() {
    _currentInvestmentValue =
        _initialInvestment * pow(1 + _annualReturnRate, _investmentYears);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Kiddo Investment',
            style: TextStyle(fontFamily: 'Comic Sans', fontSize: 26),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Title with a playful font
            Text(
              'Grow Your Money 🌱',
              style: TextStyle(
                fontFamily: 'Comic Sans',
                fontSize: 28,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Initial Investment
            buildFunInputField(
              label: 'Initial Investment',
              icon: Icons.attach_money,
              onChanged: (value) {
                setState(() {
                  _initialInvestment = double.tryParse(value) ?? 0.0;
                  _calculateInvestmentValue();
                });
              },
            ),

            // Annual Return Rate
            buildFunInputField(
              label: 'Annual Return Rate (%)',
              icon: Icons.trending_up,
              onChanged: (value) {
                setState(() {
                  _annualReturnRate = (double.tryParse(value) ?? 0.0) / 100;
                  _calculateInvestmentValue();
                });
              },
            ),

            // Investment Duration
            buildFunInputField(
              label: 'Investment Duration (Years)',
              icon: Icons.access_time,
              onChanged: (value) {
                setState(() {
                  _investmentYears = int.tryParse(value) ?? 0;
                  _calculateInvestmentValue();
                });
              },
            ),
            SizedBox(height: 20),

            // Display Current Investment Value with a decorative background
            Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green,
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'Current Value: ₹${_currentInvestmentValue.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comic Sans',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            // Gamified Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _annualReturnRate =
                      Random().nextDouble() * 0.2; // Random rate between 0-20%
                  _calculateInvestmentValue();
                });
              },
              child: Text(
                'Spin the Wheel of Returns! 🎡',
                style: TextStyle(fontSize: 20, fontFamily: 'Comic Sans'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }

  Widget buildFunInputField({
    required String label,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.pinkAccent),
        filled: true,
        fillColor: Colors.pink[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }
}
