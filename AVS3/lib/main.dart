import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(CareerExplorerApp());
}

class CareerExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career Explorer',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomeScreen(),
    );
  }
}