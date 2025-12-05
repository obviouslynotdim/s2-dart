import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../widgets/answer_button.dart';

class QuestionScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final int index;
  final void Function(int) onAnswerSelected; 

  const QuestionScreen({
    super.key,
    required this.questions,
    required this.index,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final q = questions[index];

    return Scaffold(
      backgroundColor: Colors.blue.shade400,  
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400, 
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Question ${index + 1}/${questions.length}",
          style: const TextStyle(color: Colors.white),
          )
        ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              q.question, 
              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            ...List.generate(
              q.answers.length,
              (i) => AnswerButton(
                label: q.answers[i],
                onTap: () => onAnswerSelected(i), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}