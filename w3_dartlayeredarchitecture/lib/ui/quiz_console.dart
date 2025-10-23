import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    Map<String, int> playerScores = {};

    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Your name(or epmty): ');
      String? playerName = stdin.readLineSync();

      if (playerName == null || playerName.isEmpty) break;

      quiz.answers.clear(); // Clear previous for new player

      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.points} points)'); // question.point
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          // questionId: question.id instead
          quiz.addAnswer(Answer(questionId: question.id, answerChoice: userInput));
        } else {
          print('No answer entered. Skipping question.');
        }
        print('');
      }

      int score = quiz.getScoreInPoints();
      int percentage = quiz.getScoreInPercentage();

      playerScores[playerName] = score;

      print('$playerName, Your score in Points: $score');
      print('$playerName, Your score in Percentage: $percentage %');
    }

    playerScores.forEach((name, score) {
      print('Player: $name\tScore: $score');
    });
    print('--- Quiz Finished ---');
  }
}
