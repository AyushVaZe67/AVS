import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductScreen extends StatelessWidget {
  final String shopName;
  final List<Product> cart;
  final Function(List<Product>, int) updateCart;
  final int balance;

  ProductScreen({
    required this.shopName,
    required this.cart,
    required this.updateCart,
    required this.balance,
  });

  final Map<String, List<Product>> shopProducts = {
    'Toy Shop': [
      Product(name: 'Toy Car', price: 30, imageAsset: 'assets/images/p2_toycar.png'),
      Product(name: 'Doll', price: 50, imageAsset: 'assets/images/p4_doll.png'),
      Product(name: 'Building Blocks', price: 20, imageAsset: 'assets/images/p6_blocks.png'),
    ],
    'Food Shop': [
      Product(name: 'Banana', price: 20, imageAsset: 'assets/images/p7_banana.png'),
      Product(name: 'Pizza', price: 40, imageAsset: 'assets/images/p8_pizza.png'),
      Product(name: 'Juice', price: 15, imageAsset: 'assets/images/p9_juice.png'),
    ],
    'Clothes Shop': [
      Product(name: 'Shirt', price: 50, imageAsset: 'assets/images/p10_shirt.png'),
      Product(name: 'Jeans', price: 60, imageAsset: 'assets/images/p11_cap.png'),
      Product(name: 'Jacket', price: 80, imageAsset: 'assets/images/p12_kurta.png'),
    ],
  };


  @override
  Widget build(BuildContext context) {
    final products = shopProducts[shopName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(shopName),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  product.imageAsset,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text('Price: Rs. ${product.price}'),
              trailing: ElevatedButton(
                onPressed: () {
                  if (balance >= product.price) {
                    cart.add(product);
                    updateCart(cart, balance - product.price);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Insufficient balance')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: balance >= product.price ? Colors.green : Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  balance >= product.price ? 'Add to Cart' : 'Not Enough',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
