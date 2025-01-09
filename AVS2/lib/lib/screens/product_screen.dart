import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductScreen extends StatefulWidget {
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

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late int _balance;
  late List<Product> _cart;

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
  void initState() {
    super.initState();
    _balance = widget.balance;
    _cart = List.from(widget.cart);
  }

  void _addToCart(Product product) {
    if (_balance >= product.price) {
      setState(() {
        _cart.add(product);
        _balance -= product.price;
      });
      widget.updateCart(_cart, _balance);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} added to cart')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient balance')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = shopProducts[widget.shopName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shopName),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isAffordable = _balance >= product.price;

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
                onPressed: isAffordable ? () => _addToCart(product) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAffordable ? Colors.green : Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  isAffordable ? 'Add to Cart' : 'Not Enough',
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
