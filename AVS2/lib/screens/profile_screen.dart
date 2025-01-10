import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import '../models/product.dart';

class ProfileScreen extends StatefulWidget {
  final List<Product> cart;
  final int balance;
  final Function(List<Product>, int) updateCartAndBalance;

  ProfileScreen({
    required this.cart,
    required this.balance,
    required this.updateCartAndBalance,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<Product> _cart;
  late int _balance;

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.cart); // Clone the cart
    _balance = widget.balance;
  }

  void _removeFromCart(int index) {
    setState(() {
      _balance += _cart[index].price; // Refund the price
      _cart.removeAt(index); // Remove the product
      widget.updateCartAndBalance(_cart, _balance); // Notify parent
    });
  }

  int _calculateTotalPrice() {
    return _cart.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Vibrant AppBar color
        title: const Text(
          'Your Profile',
          style: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Add settings functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Balance display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber, size: 30),
                const SizedBox(width: 8),
                Text(
                  'Rs. $_balance',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
              ],
            ),
          ),

          // Cart display
          Expanded(
            child: _cart.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'तुमची कार्ट रिकामी आहे!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comic Sans MS',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'पुढे जा, काही छान गोष्टी जोडा!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontFamily: 'Comic Sans MS',
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (context, index) {
                final product = _cart[index];
                return Card(
                  color: Colors.pink.shade50,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                  child: ListTile(
                    leading: product.imageAsset.endsWith('.json')
                        ? Lottie.asset(
                      product.imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )
                        : Image.asset(
                      product.imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Comic Sans MS',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Comic Sans MS',
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFromCart(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} removed from cart')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Total price
          Container(
            color: Colors.orange.shade100,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calculate, color: Colors.deepOrange, size: 28),
                const SizedBox(width: 10),
                Text(
                  'एकूण: रु. ${_calculateTotalPrice()}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comic Sans MS',
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
