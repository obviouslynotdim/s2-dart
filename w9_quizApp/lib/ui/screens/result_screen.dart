import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../../models/quiz.dart';

class ResultScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<int> selectedAnswers;
  final int score;
  final VoidCallback onRestartQuiz;

  const ResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        "Results",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade400,
      iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade400, 
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("You answered $score on ${questions.length} !",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, i) {
                  final q = questions[i];
                  final selected = selectedAnswers[i];
                  final correct = q.correctIndex;

                  return ListTile(
                    title: Text(q.question, style: const TextStyle(color: Colors.white70)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: q.answers.asMap().entries.map((e) {
                        final answerIndex = e.key;
                        final text = e.value;

                        Color color = Colors.white; 
                        if (answerIndex == correct) color = Colors.green.shade400;
                        if (answerIndex == selected && selected != correct) {
                          color = Colors.red.shade400;
                        }

                        return Text("• $text", style: TextStyle(color: color, fontWeight: FontWeight.bold));
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            AppButton(
              label: ("Restart Quiz"),
              onTap: onRestartQuiz, 
            )
          ],
        ),
      ),
    );
  }
}