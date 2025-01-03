import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MarketplaceApp());
}

class MarketplaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfile(),
      child: MaterialApp(
        title: 'Virtual Marketplace Simulator',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: 'Ice Cream', price: 10.0, image: const AssetImage('assets/p1_icrecream.png')),
    Product(id: '2', name: 'Car', price: 80.0, image: const AssetImage('assets/p2_toycar.png')),
    Product(id: '3', name: 'Cube', price: 50.0, image: const AssetImage('assets/p3_cube.png')),
    Product(id: '4', name: 'Doll', price: 30.0, image: const AssetImage('assets/p4_doll.png')),
    Product(id: '5', name: 'Candy', price: 5.0, image: const AssetImage('assets/p5_candy.png')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Marketplace'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg_main_1.png'), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index], index: index);
          },
        ),
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;
  final int index; // Accept index from parent

  final List<String> imagePaths = [
    'assets/p1_icrecream.png',
    'assets/p2_toycar.png',
    'assets/p3_cube.png',
    'assets/p4_doll.png',
    'assets/p5_candy.png',
  ];

  ProductCard({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(
          imagePaths[index % imagePaths.length], // Ensure safe indexing
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text('₹${product.price}'),
        trailing: ElevatedButton(
          onPressed: userProfile.balance >= product.price
              ? () {
            userProfile.buyProduct(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Purchased ${product.name}')),
            );
            // Show toast for successful purchase
            Fluttertoast.showToast(
              msg: "Purchase Successful!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
              : () {
            // Show toast for insufficient balance
            Fluttertoast.showToast(
              msg: "Insufficient Balance!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }, // Disable button if balance is insufficient
          style: ElevatedButton.styleFrom(
            backgroundColor: userProfile.balance >= product.price
                ? Colors.green // Green if balance is sufficient
                : Colors.red,  // Red if balance is insufficient
          ),
          child: Text('Buy'),
        ),
      ),
    );
  }
}


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        color: Colors.lightBlue[50], // Background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Balance: ₹${userProfile.balance}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            const Text('Purchased Products:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: userProfile.purchasedProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green), // Icon for purchased product
                    title: Text(userProfile.purchasedProducts[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Remove product from the purchased list
                        userProfile.removeProduct(userProfile.purchasedProducts[index]);
                        Fluttertoast.showToast(
                          msg: "Product removed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Product {
  final String id;
  final String name;
  final double price;
  final AssetImage image;

  Product({required this.id, required this.name, required this.price, required this.image});
}

class UserProfile with ChangeNotifier {
  double _balance = 100.0; // Starting balance
  List<Product> _purchasedProducts = [];

  double get balance => _balance;
  List<Product> get purchasedProducts => _purchasedProducts;

  void buyProduct(Product product) {
    _balance -= product.price;
    _purchasedProducts.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _balance += product.price; // Refund the amount back to the balance
    _purchasedProducts.remove(product);
    notifyListeners();
  }
}
