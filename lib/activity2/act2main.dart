import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(FamilyBudgetGameApp());
}

class FamilyBudgetGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family Budget Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Budget Game"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the Family Budget Simulation!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Learn how to manage a family's budget through fun challenges.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScenarioScreen(),
                  ),
                );
              },
              child: Text("Start Simulation"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScenarioScreen extends StatefulWidget {
  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final controller1 = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    // super.initState();
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 4),
    // );
    controller1.addListener(() {
      setState(() {
        isPlaying = controller1.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final double totalBudget = 100;
  double allocatedBudget = 0;
  double remainingBudget = 100;

  final Map<String, double> categories = {
    "Food": 0,
    "Education": 0,
    "Entertainment": 0,
    "Savings": 0,
    "Utilities": 0,
  };

  final List<String> scenarios = [
    "The family has a special event this month, which means increased spending on food and entertainment. Adjust your budget accordingly.",
    "Unexpected utility bills have arrived. Can you allocate enough without affecting other essential categories?",
    "The family needs to save for an upcoming vacation. Focus on maximizing savings while managing other expenses.",
  ];

  int currentScenario = 0;

  void updateCategory(String category, double value) {
    setState(() {
      double newAllocatedBudget =
          allocatedBudget - categories[category]! + value;

      if (newAllocatedBudget <= totalBudget && value >= 0) {
        allocatedBudget = newAllocatedBudget;
        remainingBudget = totalBudget - allocatedBudget;
        categories[category] = value;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Invalid allocation! Budget exceeded or negative input."),
          ),
        );
      }
    });
  }

  void proceedToResult() {
    var ticker = _controller.forward();
    ticker.whenComplete(() => () {
          _controller.reset();
        });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          scenario: scenarios[currentScenario],
          budget: categories,
          totalBudget: totalBudget,
          allocatedBudget: allocatedBudget,
          remainingBudget: remainingBudget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
    alignment: Alignment.topCenter,
    children: [
      Scaffold(
        appBar: AppBar(
          title: Text("Scenario ${currentScenario + 1}"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scenarios[currentScenario],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: categories.keys.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 120,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "₹",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                double budget = double.tryParse(value) ?? 0;
                                if (budget < 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Budget cannot be negative!")),
                                  );
                                } else {
                                  updateCategory(category, budget);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Allocated Budget: ₹${allocatedBudget.toStringAsFixed(2)} / ₹${totalBudget.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: allocatedBudget > totalBudget
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  Text(
                    "Remaining Budget: ₹${remainingBudget.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: remainingBudget >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ResultScreen(
                  //       scenario: scenarios[currentScenario],
                  //       budget: categories,
                  //       totalBudget: totalBudget,
                  //       allocatedBudget: allocatedBudget,
                  //       remainingBudget: remainingBudget,
                  //     ),
                  //   ),
                  // );
                  if (isPlaying) {
                    controller1.stop();
                  } else {
                    controller1.play();
                  }
                },
                child: Text("Submit Budget"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      ConfettiWidget(
        confettiController: controller1,
        shouldLoop: true,
        blastDirectionality: BlastDirectionality.explosive,
        numberOfParticles: 80,
        emissionFrequency: 0.5,
        gravity: 0.8,
        minBlastForce: 20,
        maxBlastForce: 100,
      )
      // Lottie.asset(
      //   "assets/animations/celebration.json",
      //   controller: _controller,
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   fit: BoxFit.cover,
      //   repeat: false,
      //   // errorBuilder: (context, error, stackTrace) {
      //   //   return Center(child: Text('Error loading animation: $error'));
      //   // },
      // ),
    ]);
  }
}

class ResultScreen extends StatelessWidget {
  final String scenario;
  final Map<String, double> budget;
  final double totalBudget;
  final double allocatedBudget;
  final double remainingBudget;

  ResultScreen({
    required this.scenario,
    required this.budget,
    required this.totalBudget,
    required this.allocatedBudget,
    required this.remainingBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Scenario Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              scenario,
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: budget.entries.map((entry) {
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text(
                      "₹${entry.value.toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(),
            Text(
              "Total Spent: ₹${allocatedBudget.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Remaining Budget: ₹${remainingBudget.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: remainingBudget >= 0 ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
