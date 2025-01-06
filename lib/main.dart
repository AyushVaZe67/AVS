import 'package:bytemind/activity1/act1main.dart';
import 'package:bytemind/activity2/act2main.dart';
import 'package:bytemind/activity3/act3main.dart';
import 'package:bytemind/activity4/act4main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MarketplaceApp());
}

class MarketplaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfile(),
      child: MaterialApp(
        title: 'Finance Marketplace',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: StartScreen(),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Finance Marketplace',
          style: TextStyle(fontFamily: 'Comic Sans', fontSize: 24),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Marketplace 1 Card
            buildFunCard(
              color: Colors.yellowAccent,
              icon: Icons.shopping_cart,
              label: 'Fun Market 1',
              context: context,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            // Marketplace 2 Card
            buildFunCard(
              color: Colors.lightBlueAccent,
              icon: Icons.store,
              label: 'Adventure Market 2',
              context: context,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvestmentSimulator()),
                );
              },
            ),
            SizedBox(height: 20),
            // Marketplace 3 Card
            buildFunCard(
              color: Colors.greenAccent,
              icon: Icons.calculate,
              label: 'Learning Market 3',
              context: context,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoanCalculator()),
                );
              },
            ),
            SizedBox(height: 20),
            // Marketplace 3 Card
            buildFunCard(
              color: Colors.greenAccent,
              icon: Icons.family_restroom,
              label: 'FamilyBudgetGameApp 4',
              context: context,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FamilyBudgetGameApp()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.pink[50],
    );
  }

  Widget buildFunCard({
    required Color color,
    required IconData icon,
    required String label,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: color,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Comic Sans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
