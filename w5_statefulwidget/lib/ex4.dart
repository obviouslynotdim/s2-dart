import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ScoreTracker(
                  title: 'My score in Flutter',
                  initialScore: 0.5,
                  activeColor: Colors.green,
                ),
                SizedBox(height: 16),
                ScoreTracker(
                  title: 'My score in Dart',
                  initialScore: 0.4,
                  activeColor: Colors.lightGreen,
                ),
                SizedBox(height: 16),
                ScoreTracker(
                  title: 'My score in React',
                  initialScore: 1,
                  activeColor: Colors.green.shade900,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class ScoreTracker extends StatefulWidget {
  final String title;
  final double initialScore;
  final Color activeColor;

  const ScoreTracker({
    required this.title,
    required this.initialScore,
    required this.activeColor,
    super.key,
  });

  @override
  State<ScoreTracker> createState() => _ScoreTrackerState();
}

class _ScoreTrackerState extends State<ScoreTracker> {
  late double _currentScore;
  final double _step = 0.1;

  @override
  void initState() {
    super.initState();
    _currentScore = widget.initialScore.clamp(0, 1);
  }

  void _incrementScore() {
    setState(() {
      _currentScore = (_currentScore + _step).clamp(0.0, 1.0);
    });
  }

  void _decrementScore() {
    setState(() {
      _currentScore = (_currentScore - _step).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Title
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),

          /// Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _decrementScore,
                child: Text("-", style: TextStyle(fontSize: 20, color: Colors.grey),),
              ),
              SizedBox(width: 80),
              GestureDetector(
                onTap: _incrementScore,
                child: Text("+", style: TextStyle(fontSize: 20, color: Colors.grey),),
              ),
            ],
          ),

          /// Progress bar
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _currentScore,
                color: widget.activeColor,
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
