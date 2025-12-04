import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

class QuestionScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuestionScreen({super.key, required this.questions});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int index = 0;
  int score = 0;
  List<int> selected = [];

  void nextQuestion(int answerIndex) {
    selected.add(answerIndex);

    if (answerIndex == widget.questions[index].correctIndex) {
      score++;
    }

    if (index < widget.questions.length - 1) {
      setState(() => index++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            questions: widget.questions,
            selectedAnswers: selected,
            score: score,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[index];

    return Scaffold(
      backgroundColor: Colors.blue.shade400,  
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400, 
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Question ${index + 1}",
          style: const TextStyle(color: Colors.white),
          )
        ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(q.question, style: const TextStyle(fontSize: 22, color: Colors.white,)),
            const SizedBox(height: 20),
            ...List.generate(
              q.answers.length,
              (i) => AnswerButton(
                text: q.answers[i],
                onTap: () => nextQuestion(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
