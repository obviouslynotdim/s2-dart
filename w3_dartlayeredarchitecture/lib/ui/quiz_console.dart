import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  final Quiz quiz;

  QuizConsole({required this.quiz});

  
  void startGame() {
    print('--- Welcome to the Quiz ---\n');
    while (true) {
      stdout.write('Your name(or empty to quit): ');
      String? playerName = stdin.readLineSync();

      if (playerName == null || playerName.isEmpty) break;

      Player player = Player(name: playerName, quiz: quiz);

      // This list holds the answers for the current session
      final List<Answer> sessionAnswers = [];

      // These helper functions now live inside 'startGame'
      int getScoreInPoints() {
        int score = 0;
        for (var answer in sessionAnswers) {
          final question = quiz.getQuestionById(answer.questionId);

          if (question != null &&
              answer.answerChoice.trim().toLowerCase() ==
                  question.goodChoice.trim().toLowerCase()) {
            score += question.points;
          }
        }
        return score;
      }

      int getScoreInPercentage() {
        final totalPoints = quiz.totalPoints;
        if (totalPoints == 0) return 0;

        final scorePoints = getScoreInPoints();
        return ((scorePoints / totalPoints) * 100).round();
      }

      // 1. Check if player has already taken the quiz (using player.id)
      if (quiz.getAnswersByUserId(player.id).isNotEmpty) {
        print('\n--- Quiz Already Taken ---');
        print('${player.name}, you have already completed this quiz.');
        print(
            'Your last recorded score is: ${quiz.getScoreInPoints(player.id)} points.');
        continue; 
      }

      print('Your name: ${player.name}');

      // 2. Run the quiz loop
      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.points} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? input = stdin.readLineSync();

        if (input != null && input.isNotEmpty) {
          sessionAnswers.add(
            Answer(
              questionId: question.id,
              answerChoice: input,
              userId: player.id, 
            ),
          );
        } else {
          print('No answer entered. Skipping question.');
        }
      }

      // 3. Score the session
      final score = getScoreInPoints();
      final percentage = getScoreInPercentage();

      print('${player.name}, Your score in percentage: $percentage %');
      print('${player.name}, Your score in Points: $score');      

      // 4. Persist answers to the main Quiz list
      sessionAnswers.forEach((answer) => quiz.addAnswer(answer, player.name));
      quiz.printAllScores();
    }
  

    print('--- Quiz Finished ---');
  }
}
