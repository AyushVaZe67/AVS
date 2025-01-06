import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MarketplaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfile(),
      child: MaterialApp(
        title: 'Marketplace App',
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Ice Cream',
      price: 10.0,
      image: const AssetImage('assets/p1_icrecream.png'),
    ),
    Product(
      id: '2',
      name: 'Car',
      price: 80.0,
      image: const AssetImage('assets/p2_toycar.png'),
    ),
    Product(
      id: '3',
      name: 'Cube',
      price: 50.0,
      image: const AssetImage('assets/p3_cube.png'),
    ),
    Product(
      id: '4',
      name: 'Doll',
      price: 30.0,
      image: const AssetImage('assets/p4_doll.png'),
    ),
    Product(
      id: '5',
      name: 'Candy',
      price: 5.0,
      image: const AssetImage('assets/p5_candy.png'),
    ),
  ];

  List<Offset> generateNonOverlappingPositions(
      BuildContext context,
      int count,
      double cardWidth,
      double cardHeight,
      ) {
    final random = Random();
    final positions = <Offset>[];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    while (positions.length < count) {
      double left = random.nextDouble() * (screenWidth - cardWidth);
      double top = random.nextDouble() * (screenHeight - cardHeight - kToolbarHeight);

      final newPosition = Offset(left, top);

      if (positions.every((existingPosition) {
        final dx = existingPosition.dx - newPosition.dx;
        final dy = existingPosition.dy - newPosition.dy;
        final distance = sqrt(dx * dx + dy * dy);
        return distance > max(cardWidth, cardHeight);
      })) {
        positions.add(newPosition);
      }
    }

    return positions;
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = 150.0;
    final cardHeight = 200.0;

    final positions = generateNonOverlappingPositions(context, products.length, cardWidth, cardHeight);

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
        child: Stack(
          children: products.asMap().entries.map((entry) {
            final product = entry.value;
            final position = positions[entry.key];

            return Positioned(
              left: position.dx,
              top: position.dy,
              child: ProductCard(product: product, width: cardWidth, height: cardHeight),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final double width;
  final double height;

  ProductCard({
    required this.product,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 8.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: product.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          Text(
            product.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            '₹${product.price}',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: userProfile.balance >= product.price
                ? () {
              userProfile.buyProduct(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Purchased ${product.name}')),
              );
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
              Fluttertoast.showToast(
                msg: "Insufficient Balance!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: userProfile.balance >= product.price
                  ? Colors.green
                  : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('Buy'),
          ),
        ],
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
        color: Colors.lightBlue[50],
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
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text(userProfile.purchasedProducts[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
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
  double _balance = 100.0;
  List<Product> _purchasedProducts = [];

  double get balance => _balance;
  List<Product> get purchasedProducts => _purchasedProducts;

  void buyProduct(Product product) {
    _balance -= product.price;
    _purchasedProducts.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _balance += product.price;
    _purchasedProducts.remove(product);
    notifyListeners();
  }
}
