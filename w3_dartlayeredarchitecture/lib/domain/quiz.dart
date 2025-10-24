import 'package:uuid/uuid.dart';

final _uuid = Uuid();

// Question Class
class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
    required this.points,
    String? id, // id reconstruction
  }) : id = id ?? _uuid.v4(); // generate uuid if id is null

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'choices': choices,
      'goodChoice': goodChoice,
      'points': points,
    };
  }
}

// Answer Class
class Answer {
  final String id;
  final String questionId;
  final String answerChoice;
  final String userId;

  Answer({
    required this.questionId,
    required this.answerChoice,
    required this.userId,
    String? id,
  }) : id = id ?? _uuid.v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'answerChoice': answerChoice,
      'userId': userId,
    };
  }

  // Check if this answer is correct
  bool isGood(Question question) {
    return answerChoice.trim().toLowerCase() ==
        question.goodChoice.trim().toLowerCase();
  }
}

// Quiz Class
class Quiz {
  final String id;
  final List<Question> questions;
  final List<Answer> answers; // stores all submitted answers from all players
  final Map<String, String> players = {};

  Quiz({required this.questions, List<Answer>? answers, String? id})
      : id = id ?? _uuid.v4(),
        answers = answers ?? [];

  void addAnswer(Answer answer, String playerName) {
    answers.add(answer);
    players[answer.userId] = playerName; // Store ID -> Name mapping
  }

  void addPlayer(Player player) {
    players[player.id] = player.name; // ensures player name exists
  }

  // getter to retrieve a question by its ID
  Question? getQuestionById(String id) {
    try {
      return questions.firstWhere((q) => q.id == id);
    } catch (e) {
      return null;
    }
  }

  // retrieve answers submitted by a specific user
  List<Answer> getAnswersByUserId(String userId) {
    return answers.where((a) => a.userId == userId).toList();
  }

  // calculate total points for quiz
  int get totalPoints {
    return questions.fold(0, (sum, q) => sum + q.points);
  }

  int getScoreInPoints(String userId) {
    int score = 0;
    final userAnswers = getAnswersByUserId(userId);

    for (final answer in userAnswers) {
      final question = getQuestionById(answer.questionId);
      if (question != null && answer.isGood(question)) {
        // use isGood()
        score += question.points;
      }
    }
    return score;
  }

  int getScoreInPercentage(String userId) {
    final points = getScoreInPoints(userId);
    if (totalPoints == 0) return 0;
    return ((points / totalPoints) * 100).round();
  }

  void printAllScores() {
    final userIds = answers.map((a) => a.userId).toSet();
    if (userIds.isEmpty) {
      print('No scores yet.');
      return;
    }
    userIds.forEach((id) {
      final playerName = players[id] ?? 'Unknown Player ($id)';
      final score = getScoreInPoints(id);
      print('Player: $playerName\tScore: $score\t"ID: $id"');
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toJson()).toList(),
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}

// Player Class
class Player {
  final String id;
  final String name;
  final Quiz quiz;

  Player({
    required this.name,
    required this.quiz,
    String? id,
  }) : id = id ?? _uuid.v4();

  void addAnswer(String questionId, String answerChoice) {
    final answer = Answer(
      questionId: questionId,
      answerChoice: answerChoice,
      userId: id,
    );
    quiz.addAnswer(answer, name);
  }

  int getScoreInPoints() => quiz.getScoreInPoints(id);
  int getScoreInPercentage() => quiz.getScoreInPercentage(id);
}
