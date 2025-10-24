import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  List<Question> questions = [
    Question(
      title: "3 + 3 = ?",
      choices: ["2", "3", "6"],
      goodChoice: "6",
      points: 50,
    ),
    Question(
      title: "2 + 2 = ?",
      choices: ["2", "4", "5"],
      goodChoice: "4",
      points: 50,
    ),
  ];

  Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startGame();
}
