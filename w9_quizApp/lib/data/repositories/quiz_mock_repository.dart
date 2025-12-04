import '../../models/quiz.dart';

class QuizMockRepository {
  List<QuizQuestion> loadQuestions() {
    return [
      QuizQuestion(
        question: "Who is the best teacher?",
        answers: ["Ronan", "Hongly", "Leangsiv"],
        correctIndex: 0,
      ),
      QuizQuestion(
        question: "What is the best color?",
        answers: ["Blue", "Red", "Green"],
        correctIndex: 2,
      ),
    ];
  }
}
