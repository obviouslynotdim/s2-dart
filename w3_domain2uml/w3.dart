class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
  });
}

class Answer {
  final String answerChoice;
  final bool isGoodAnswer;
  final Question question;

  Answer({
    required this.answerChoice,
    required this.isGoodAnswer,
    required this.question,
  });
}

class Quiz {
  final List<Question> questions;
  final List<Answer> _answers = [];

  Quiz({required this.questions});

  void addAnswer(Answer answer) { // use void when doesnt return result
    _answers.add(answer);
  }

  int getScore() {
    int score = 0;
    for (var answer in _answers) {
      if (answer.isGoodAnswer) {
        score++;
      }
    }
    return score;
  }
  // int get score => _answers.where((a) => a.isGoodAnswer).length;
}
