import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_screen.dart';
import 'profile_screen.dart';
import '../widgets/shop_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _balance = 100;
  List<Product> _cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(cart: _cart, balance: _balance),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Displaying Balance at the Top Center
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
                  const SizedBox(width: 5),
                  Text(
                    'Rs. $_balance',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Grid of Shops
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              children: [
                ShopItem(
                  shopName: 'Toy Shop',
                  imageAsset: 'assets/images/main_toy.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          shopName: 'Toy Shop',
                          cart: _cart,
                          updateCart: _updateCart,
                          balance: _balance,
                        ),
                      ),
                    );
                  },
                ),
                ShopItem(
                  shopName: 'Food Shop',
                  imageAsset: 'assets/images/main_food.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          shopName: 'Food Shop',
                          cart: _cart,
                          updateCart: _updateCart,
                          balance: _balance,
                        ),
                      ),
                    );
                  },
                ),
                ShopItem(
                  shopName: 'Clothes Shop',
                  imageAsset: 'assets/images/main_clothes.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          shopName: 'Clothes Shop',
                          cart: _cart,
                          updateCart: _updateCart,
                          balance: _balance,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Update cart and balance when a product is added
  void _updateCart(List<Product> updatedCart, int newBalance) {
    setState(() {
      _cart = updatedCart;
      _balance = newBalance;
    });
  }
}
