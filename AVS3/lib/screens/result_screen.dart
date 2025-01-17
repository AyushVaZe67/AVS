import 'package:bytemind2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'explore_screen.dart'; // Assuming you have the ExploreScreen defined.

class ResultScreen extends StatelessWidget {
  final String category;
  final List<String> suggestions;

  ResultScreen({required this.category, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Career Results'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/showentre.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Career Suggestion Box
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.pinkAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.pinkAccent.shade100,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Career Suggestions Heading
                      Text(
                        'Your Career Suggestions:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Comic Sans MS',
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Career Suggestions List
                      if (suggestions.isNotEmpty)
                        Column(
                          children: suggestions
                              .map((suggestion) => GestureDetector(
                            onTap: () {
                              // Navigate to ExploreScreen when the user clicks a suggestion
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExploreScreen(
                                    career: suggestion,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              margin: const EdgeInsets.only(top: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.work, size: 40, color: Colors.deepPurple),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        suggestion,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Comic Sans MS',
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Restart Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false,
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restart_alt, color: Colors.white, size: 24),
                        SizedBox(width: 10),
                        Text(
                          'Restart',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
