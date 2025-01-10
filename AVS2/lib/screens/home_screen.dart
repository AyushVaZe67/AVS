import 'package:audioplayers/audioplayers.dart';
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

  final player = AudioPlayer();

  int _balance = 300;
  List<Product> _cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          playSound();
        },
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.star, // Fun icon for the fair
              color: Colors.yellowAccent, // Bright color to contrast with blue
            ),
            const SizedBox(width: 8),
            Text(
              'जत्रा',
              style: const TextStyle(
                fontFamily: 'Cursive', // Custom playful font style
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Title text in white for contrast
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue, // Matching the Scaffold background color
        elevation: 6, // Slight elevation to give depth
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white, // White icon for contrast
              size: 28, // Larger icon size for prominence
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    cart: _cart,
                    balance: _balance,
                    updateCartAndBalance: _updateCartAndBalance,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings, // Add settings for more functionality
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Settings action here
            },
          ),
        ],
      ),


      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fair_bg.jpg'), // Background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Column(
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
            // Title for Shops
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Welcome to the Fun Fair!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),

            // Grid of Shops
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                padding: const EdgeInsets.all(8.0),
                children: [
                  ShopItem(
                    shopName: 'खेळणी',
                    imageAsset: 'assets/images/main_toy.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            shopName: 'Toy Shop',
                            cart: _cart,
                            updateCart: _updateCartAndBalance,
                            balance: _balance,
                          ),
                        ),
                      );
                    },
                  ),
                  ShopItem(
                    shopName: 'खाण्याचे दुकान',
                    imageAsset: 'assets/images/main_food.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            shopName: 'Food Shop',
                            cart: _cart,
                            updateCart: _updateCartAndBalance,
                            balance: _balance,
                          ),
                        ),
                      );
                    },
                  ),
                  ShopItem(
                    shopName: 'कपड्यांचे दुकान',
                    imageAsset: 'assets/images/main_clothes.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            shopName: 'Clothes Shop',
                            cart: _cart,
                            updateCart: _updateCartAndBalance,
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
      ),
    );
  }

  // Update cart and balance when a product is added/removed
  void _updateCartAndBalance(List<Product> updatedCart, int newBalance) {
    setState(() {
      _cart = updatedCart;
      _balance = newBalance;
    });
  }

  Future<void> playSound() async {
    String audioPath = "assets/audio/main_music.mp3";
    await player.play(AssetSource(audioPath));
  }
}