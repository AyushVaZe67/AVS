import 'package:flutter/material.dart';
import 'package:bytemind2/screens/skill_assessment_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Career Explorer',
          style: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 26),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🎓 Explore Your Career! 🎉',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontFamily: 'Comic Sans MS',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Image.asset(
              //   'assets/images/career_kids.png',
              //   height: 150,
              // ),
              // SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shadowColor: Colors.purple,
                  elevation: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.school, color: Colors.white, size: 24),
                    SizedBox(width: 10),
                    Text(
                      'Start Skill Assessment',
                      style: TextStyle(fontSize: 18, fontFamily: 'Comic Sans MS',color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SkillAssessmentScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Discover the right path for your future! 🌟',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
