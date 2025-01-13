import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, int> categoryScores;

  ResultScreen({required this.categoryScores});

  String getCareerOption(String topCategory) {
    switch (topCategory) {
      case 'Analytical':
        return 'You should consider a career in Data Science, Analytics, or Engineering!';
      case 'Creative':
        return 'A career in Arts, Design, or Marketing could be a great fit for you!';
      case 'Technology':
        return 'You might thrive in fields like Software Development or IT!';
      case 'Communication':
        return 'Public Relations, Writing, or Journalism might suit you well!';
      case 'Leadership':
        return 'You could excel in Management, Entrepreneurship, or Leadership roles!';
      case 'Empathy':
        return 'Consider careers in Counseling, Social Work, or Healthcare!';
      case 'Teamwork':
        return 'Roles in Project Management or Collaborative Teams could be ideal!';
      case 'Detail-Oriented':
        return 'Careers in Quality Assurance, Research, or Accounting might be a good match!';
      case 'Adaptability':
        return 'Fields like Consulting or Startups might be a great fit for you!';
      default:
        return 'Explore various options to discover what excites you most!';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Find the top category by sorting the categoryScores
    final topCategory = categoryScores.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 26),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade200, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Your Top Skill Area: $topCategory',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comic Sans MS',
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    getCareerOption(topCategory),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Comic Sans MS',
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shadowColor: Colors.purpleAccent,
                elevation: 8,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restart_alt, color: Colors.white, size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Restart',
                    style: TextStyle(fontSize: 20, fontFamily: 'Comic Sans MS'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
