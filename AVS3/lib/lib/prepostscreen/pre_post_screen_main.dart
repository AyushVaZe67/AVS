import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

// Question Class
class Question {
  final String text;
  final Map<String, bool> options; // Option: Correctness

  Question({required this.text, required this.options});
}

// Translations Map
Map<String, Map<String, String>> translations = {
  'English': {
    'pre_test_title': 'Pre-Test',
    'post_test_title': 'Post-Test',
    'results_title': 'Results',
    'pre_test_score': 'Pre-Test Score',
    'post_test_score': 'Post-Test Score',
    'submit_button': 'Submit',
  },
  'Hindi': {
    'pre_test_title': 'पूर्व चाचणी',
    'post_test_title': 'उत्तर चाचणी',
    'results_title': 'परिणाम',
    'pre_test_score': 'पूर्व चाचणी स्कोर',
    'post_test_score': 'उत्तर चाचणी स्कोर',
    'submit_button': 'जमा करें',
  },
  'Marathi': {
    'pre_test_title': 'पूर्व चाचणी',
    'post_test_title': 'नंतरची चाचणी',
    'results_title': 'निकाल',
    'pre_test_score': 'पूर्व चाचणी गुण',
    'post_test_score': 'नंतरची चाचणी गुण',
    'submit_button': 'सादर करा',
  },
};

// Main Screen
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedLanguage =
      'English'; // Make it public if you want to access it from outside but not recommended here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedLanguage,
              items:
              <String>['English', 'Hindi', 'Marathi'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreTestScreen(
                      selectedLanguage: selectedLanguage,
                    ),
                  ),
                );
              },
              child: Text(translations[selectedLanguage]!['pre_test_title']!),
            ),
          ],
        ),
      ),
    );
  }
}

// Pre-Test Screen
class PreTestScreen extends StatefulWidget {
  final String selectedLanguage;
  PreTestScreen({required this.selectedLanguage});
  @override
  _PreTestScreenState createState() => _PreTestScreenState();
}

class _PreTestScreenState extends State<PreTestScreen> {
  Map<Question, String?> userAnswers = {};
  List<Question> preTestQuestions = [
    Question(
      text: 'जत्रेत वस्तूंची किंमत कोण ठरवतो?',
      options: {
        'फक्त दुकानदार': false,
        'फक्त ग्राहक': false,
        'मागणी आणि पुरवठा': true,
        'सरकार': false,
      },
    ),
    Question(
      text: 'जत्रेत वस्तू कशा विकल्या जातात?',
      options: {
        'फक्त ऑनलाइन': false,
        'फक्त रोख रक्कम': false,
        'रोख रक्कम आणि इतर पर्याय': true,
        'फक्त क्रेडिट कार्ड': false,
      },
    ),
    Question(
      text: 'कौटुंबिक अंदाजपत्रकाचा मुख्य उद्देश काय आहे?',
      options: {
        'जास्त खर्च करणे': false,
        'बचत कमी करणे': false,
        'आर्थिक व्यवस्थापन करणे': true,
        'कर्ज घेणे': false,
      },
    ),
    Question(
      text: 'अंदाजपत्रकात काय समाविष्ट असते?',
      options: {
        'फक्त उत्पन्न': false,
        'फक्त खर्च': false,
        'उत्पन्न आणि खर्च दोन्ही': true,
        'फक्त कर्ज': false,
      },
    ),
    Question(
      text: 'गुंतवणूक म्हणजे काय?',
      options: {
        'पैसे खर्च करणे': false,
        'पैसे वाचवणे': false,
        'भविष्यात फायदा मिळावा यासाठी पैसे गुंतवणे': true,
        'पैसे दान करणे': false,
      },
    ),
    Question(
      text: 'बचत करणे का महत्त्वाचे आहे?',
      options: {
        'फक्त मजा करण्यासाठी': false,
        'फक्त खर्च करण्यासाठी': false,
        'भविष्यातील गरजांसाठी': true,
        'इतरांना देण्यासाठी': false,
      },
    ),
    Question(
      text: 'कर्ज म्हणजे काय?',
      options: {
        'पैसे देणे': false,
        'पैसे घेणे आणि परत करणे': true,
        'पैसे वाचवणे': false,
        'पैसे दान करणे': false,
      },
    ),
    Question(
      text: 'कर्ज घेताना काय लक्षात घ्यावे लागते?',
      options: {
        'फक्त व्याजदर': false,
        'फक्त परतफेड करण्याची मुदत': false,
        'व्याजदर आणि परतफेड करण्याची मुदत दोन्ही': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'नोकरी म्हणजे काय?',
      options: {
        'स्वतःचा व्यवसाय करणे': false,
        'दुसऱ्यासाठी काम करणे': true,
        'पैसे दान करणे': false,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'उद्यमशीलता म्हणजे काय?',
      options: {
        'नोकरी करणे': false,
        'स्वतःचा व्यवसाय सुरू करणे': true,
        'पैसे वाचवणे': false,
        'यापैकी काहीही नाही': false,
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (var question in preTestQuestions) {
      userAnswers[question] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translations[widget.selectedLanguage]!['pre_test_title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: preTestQuestions.length,
                itemBuilder: (context, index) {
                  final question = preTestQuestions[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question.text),
                      for (var option in question.options.keys)
                        RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: userAnswers[question],
                          onChanged: (String? value) {
                            setState(() {
                              userAnswers[question] = value;
                            });
                          },
                        ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostTestScreen(
                      selectedLanguage: widget.selectedLanguage,
                      preTestAnswers: userAnswers,
                    ),
                  ),
                );
              },
              child: Text(
                  translations[widget.selectedLanguage]!['submit_button']!),
            ),
          ],
        ),
      ),
    );
  }
}

// Post-Test Screen
class PostTestScreen extends StatefulWidget {
  final String selectedLanguage;
  final Map<Question, String?> preTestAnswers; // This is required!

  const PostTestScreen(
      {Key? key, required this.selectedLanguage, required this.preTestAnswers})
      : super(key: key);
  @override
  _PostTestScreenState createState() => _PostTestScreenState();
}

class _PostTestScreenState extends State<PostTestScreen> {
  Map<Question, String?> userAnswers = {};
  List<Question> postTestQuestions = [
    Question(
      text: 'जत्रेत यशस्वी विक्रेता होण्यासाठी काय आवश्यक आहे?',
      options: {
        'फक्त कमी किंमत': false,
        'फक्त जास्त नफा': false,
        'मागणी, पुरवठा आणि योग्य किंमत': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'जत्रेत ग्राहकांना आकर्षित करण्यासाठी काय करता येईल?',
      options: {
        'फक्त जाहिरात': false,
        'फक्त सवलत': false,
        'चांगल्या वस्तू, योग्य किंमत आणि आकर्षक मांडणी': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'कौटुंबिक अंदाजपत्रक बनवण्याचे फायदे काय आहेत?',
      options: {
        'खर्च वाढतो': false,
        'कर्ज वाढते': false,
        'आर्थिक नियोजन आणि बचत करता येते': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'अंदाजपत्रक बनवताना कोणत्या गोष्टी लक्षात घ्याव्यात?',
      options: {
        'फक्त उत्पन्न': false,
        'फक्त खर्च': false,
        'उत्पन्न, खर्च आणि भविष्यातील गरजा': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'गुंतवणुकीचे फायदे काय आहेत?',
      options: {
        'पैसे कमी होतात': false,
        'जोखीम नसते': false,
        'भविष्यात आर्थिक सुरक्षितता मिळते': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'बचत करण्याचे वेगवेगळे मार्ग कोणते आहेत?',
      options: {
        'फक्त बँकेत पैसे ठेवणे': false,
        'फक्त खर्च कमी करणे': false,
        'बँकेत ठेवणे, खर्च कमी करणे आणि गुंतवणूक करणे': true,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'कर्ज घेण्याचे तोटे काय आहेत?',
      options: {
        'फायदा होतो': false,
        'परतफेड करावी लागते': true,
        'जबाबदारी वाढते': true,
        '(b) आणि (c) दोन्ही': true,
      },
    ),
    Question(
      text: 'कर्जाचे व्यवस्थापन कसे करावे?',
      options: {
        'जास्त कर्ज घ्यावे': false,
        'वेळेवर परतफेड करावी': true,
        'कर्जाबद्दल विचार करू नये': false,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'नोकरी आणि उद्यमशीलता यात काय फरक आहे?',
      options: {
        'दोन्ही एकच आहेत': false,
        'नोकरीत दुसऱ्यासाठी काम करावे लागते, तर उद्योजकतेत स्वतःचा व्यवसाय सुरू करावा लागतो':
        true,
        'नोकरीत जास्त पैसे मिळतात': false,
        'यापैकी काहीही नाही': false,
      },
    ),
    Question(
      text: 'यशस्वी उद्योजक होण्यासाठी काय गुण आवश्यक आहेत?',
      options: {
        'फक्त पैसे': false,
        'फक्त शिक्षण': false,
        'कष्ट, आत्मविश्वास आणि नवीन कल्पना': true,
        'यापैकी काहीही नाही': false,
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (var question in postTestQuestions) {
      userAnswers[question] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translations[widget.selectedLanguage]!['post_test_title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: postTestQuestions.length,
                itemBuilder: (context, index) {
                  final question = postTestQuestions[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question.text),
                      for (var option in question.options.keys)
                        RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: userAnswers[question],
                          onChanged: (String? value) {
                            setState(() {
                              userAnswers[question] = value;
                            });
                          },
                        ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsScreen(
                      preTestAnswers: widget.preTestAnswers,
                      postTestAnswers: userAnswers,
                      selectedLanguage: widget.selectedLanguage,
                    ),
                  ),
                );
              },
              child: Text(
                  translations[widget.selectedLanguage]!['submit_button']!),
            ),
          ],
        ),
      ),
    );
  }
}

// ... (Other classes and translations as before)

// Results Screen
class ResultsScreen extends StatelessWidget {
  final Map<Question, String?> preTestAnswers;
  final Map<Question, String?> postTestAnswers;
  final String selectedLanguage;

  ResultsScreen({
    required this.preTestAnswers,
    required this.postTestAnswers,
    required this.selectedLanguage,
  });

  int calculateScore(Map<Question, String?> answers) {
    int score = 0;
    answers.forEach((question, answer) {
      if (answer != null && question.options[answer] == true) {
        score++;
      }
    });
    return score;
  }

  @override
  Widget build(BuildContext context) {
    int preTestScore = calculateScore(preTestAnswers);
    int postTestScore = calculateScore(postTestAnswers);

    return Scaffold(
      appBar: AppBar(
        title: Text(translations[selectedLanguage]!['results_title']!),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translations[selectedLanguage]!['pre_test_score']! +
                    ': $preTestScore / ${preTestAnswers.length}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                translations[selectedLanguage]!['post_test_score']! +
                    ': $postTestScore / ${postTestAnswers.length}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20), // Space between scores and feedback

              // Display Correct/Incorrect Answers (Optional but highly recommended)
              Expanded(
                // Use Expanded to allow scrolling if needed
                child: ListView(
                  children: [
                    _buildAnswerFeedback(preTestAnswers, "Pre-Test"),
                    _buildAnswerFeedback(postTestAnswers, "Post-Test"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerFeedback(Map<Question, String?> answers, String testType) {
    List<Widget> feedbackWidgets = [];
    answers.forEach((question, answer) {
      bool isCorrect = answer != null && question.options[answer] == true;
      feedbackWidgets.add(Card(
        // Use Card for better visual separation
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.text,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  "Your Answer: ${answer ?? "Not Answered"}"), // Show "Not Answered" if no answer
              Text(
                "Correct Answer: ${question.options.entries.firstWhere((entry) => entry.value).key}", // Display the correct answer
                style: TextStyle(
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
              if (!isCorrect) ...[
                // Show explanation only if incorrect (Optional)
                SizedBox(height: 8),
                Text(
                    "Explanation: (Add your explanations here)"), // Replace with your actual explanations
              ],
            ],
          ),
        ),
      ));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(testType + " Answers:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...feedbackWidgets,
      ],
    );
  }
}