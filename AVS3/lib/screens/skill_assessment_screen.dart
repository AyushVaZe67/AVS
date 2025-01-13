import 'package:flutter/material.dart';
import 'package:bytemind2/screens/result_screen.dart';

class SkillAssessmentScreen extends StatefulWidget {
  @override
  _SkillAssessmentScreenState createState() => _SkillAssessmentScreenState();
}

class _SkillAssessmentScreenState extends State<SkillAssessmentScreen> {
  final List<Map<String, dynamic>> questions = [
    {'text': 'Do you enjoy solving complex problems?', 'category': 'Analytical'},
    {'text': 'Are you good at teamwork?', 'category': 'Teamwork'},
    {'text': 'Do you like working with numbers?', 'category': 'Analytical'},
    {'text': 'Are you a creative thinker?', 'category': 'Creative'},
    {'text': 'Are you detail-oriented?', 'category': 'Detail-Oriented'},
    {'text': 'Do you have strong communication skills?', 'category': 'Communication'},
    {'text': 'Are you comfortable with public speaking?', 'category': 'Communication'},
    {'text': 'Do you enjoy working with technology?', 'category': 'Technology'},
    {'text': 'Are you a fast learner?', 'category': 'Adaptability'},
    {'text': 'Do you have a passion for helping others?', 'category': 'Empathy'},
    {'text': 'Do you enjoy working in a team environment?', 'category': 'Teamwork'},
    {'text': 'Are you interested in leadership roles?', 'category': 'Leadership'},
    {'text': 'Do you like to analyze data?', 'category': 'Analytical'},
    {'text': 'Are you creative in your approach to tasks?', 'category': 'Creative'},
    {'text': 'Do you prefer structured tasks over open-ended ones?', 'category': 'Detail-Oriented'},
    {'text': 'Do you enjoy designing or creating visual content?', 'category': 'Creative'},
    {'text': 'Are you interested in coding or software development?', 'category': 'Technology'},
    {'text': 'Do you like managing and organizing tasks or events?', 'category': 'Leadership'},
    {'text': 'Do you enjoy writing or creating content?', 'category': 'Communication'},
    {'text': 'Are you passionate about social causes or community service?', 'category': 'Empathy'},
  ];

  final Map<String, int> categoryScores = {
    'Analytical': 0,
    'Teamwork': 0,
    'Creative': 0,
    'Detail-Oriented': 0,
    'Communication': 0,
    'Technology': 0,
    'Adaptability': 0,
    'Empathy': 0,
    'Leadership': 0,
  };

  int currentQuestion = 0;

  void answerQuestion(bool answer) {
    if (answer) {
      categoryScores[questions[currentQuestion]['category']] =
          categoryScores[questions[currentQuestion]['category']]! + 1;
    }
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(categoryScores: categoryScores),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Skill Assessment',
          style: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 26),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.green.shade100],
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
              child: Text(
                questions[currentQuestion]['text'],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comic Sans MS',
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shadowColor: Colors.greenAccent,
                elevation: 5,
              ),
              onPressed: () => answerQuestion(true),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.thumb_up, color: Colors.white, size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Yes',
                    style: TextStyle(fontSize: 18, fontFamily: 'Comic Sans MS'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shadowColor: Colors.redAccent,
                elevation: 5,
              ),
              onPressed: () => answerQuestion(false),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.thumb_down, color: Colors.white, size: 24),
                  SizedBox(width: 10),
                  Text(
                    'No',
                    style: TextStyle(fontSize: 18, fontFamily: 'Comic Sans MS'),
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
