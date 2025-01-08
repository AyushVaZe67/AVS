import 'package:flutter/material.dart';
import '../models/product.dart';

class ProfileScreen extends StatefulWidget {
  final List<Product> cart;
  final int balance;

  ProfileScreen({required this.cart, required this.balance});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<Product> _cart;
  late int _balance;

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.cart); // Create a copy of the cart
    _balance = widget.balance;
  }

  void _removeFromCart(int index) {
    setState(() {
      _balance += _cart[index].price; // Add the product price back to the balance
      _cart.removeAt(index); // Remove the item from the cart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        children: [
          // Display the current balance
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Balance: Rs. $_balance',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Display the cart items
          Expanded(
            child: _cart.isEmpty
                ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    title: Text(_cart[index].name),
                    subtitle: Text('Price: Rs. ${_cart[index].price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFromCart(index); // Remove the item from the cart
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${_cart[index].name} removed from cart'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
