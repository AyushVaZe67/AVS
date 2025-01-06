// // lib/user_profile.dart
// import 'package:flutter/foundation.dart';
//
// class UserProfile with ChangeNotifier {
//   double _balance = 100.0; // Starting balance
//   List<Product> _purchasedProducts = [];
//
//   double get balance => _balance;
//   List<Product> get purchasedProducts => _purchasedProducts;
//
//   void buyProduct(Product product) {
//     _balance -= product.price;
//     _purchasedProducts.add(product);
//     notifyListeners();
//   }
// }
//
// class Product {
//   final String id;
//   final String name;
//   final double price;
//
//   Product({required this.id, required this.name, required this.price});
// }