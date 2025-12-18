import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback startQuiz;

  const WelcomeScreen({super.key, required this.startQuiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/quiz-logo.png',
              width: 300, 
              height: 300,
            ),

            const SizedBox(height: 40),

            AppButton(
              label: "Start Quiz", 
              onTap: startQuiz, 
            ),
          ],
        ),
      ),
    );
  }
}