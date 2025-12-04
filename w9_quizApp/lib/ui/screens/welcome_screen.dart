import 'package:flutter/material.dart';
import '../../data/repositories/quiz_mock_repository.dart';
import 'question_screen.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              text: "Start Quiz",
              onPressed: () {
                final questions = QuizMockRepository().loadQuestions();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestionScreen(questions: questions),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
