import 'package:bytemind1/compo2/try2.dart';
import 'package:bytemind1/compo_select.dart';
import 'package:bytemind1/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectionCompoScreen(),
    );
  }
}