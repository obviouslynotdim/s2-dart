import 'package:uuid/uuid.dart';

const _uuid = Uuid();

// Add toJson to quiz.dart

// == Question class ==
class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points; // add points

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
    required this.points,
    String? id, // optional ID for reconstruction, otherwise generate
  }) : this.id = id ?? _uuid.v4(); 

  // ADDED: toJson() method for Question
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

// == Answer Class ==
class Answer {
  final String id;
  final String questionId;
  final String answerChoice;

  Answer({
    required this.questionId, 
    required this.answerChoice,
    String? id,
  }) : this.id = id ?? _uuid.v4();

  // The isGood() logic will now depend on the Quiz class to retrieve the Question.

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'answerChoice': answerChoice,
    };
  }
}

// == Quiz Class ==
class Quiz {
  final String id;
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({
    required this.questions,
    String? id,
    List<Answer>? answers,
  }) : this.id = id ?? _uuid.v4() {
    if (answers != null) {
      this.answers = answers;
    }
  }

  void addAnswer(Answer answer) {
    this.answers.add(answer);
  }

  // New Getter: Retrieve a question from its ID
  Question? getQuestionById(String id) {
    try {
      return questions.firstWhere((q) => q.id == id);
    } catch (e) {
      return null; // return null if not found
    }
  }

  // New Getter: Retrieve an answer from its ID
  // (Less crucial for the current logic, but good for completeness)
  Answer? getAnswerById(String id) {
    try {
      return answers.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  int getScoreInPoints() {
    int score = 0;
    for (Answer answer in answers) {
      final question = getQuestionById(answer.questionId); // Get question by ID
      
      // Check if the question exists and the answer is correct
      if (question != null && answer.answerChoice == question.goodChoice) {
        score += question.points;
      }
    }
    return score;
  }

  int getScoreInPercentage() {
    int totalPoints = 0;
    for (var q in questions) {
      totalPoints += q.points;
    }
    
    // Avoid division by zero
    if (totalPoints == 0) return 0; 
    
    int scorePoints = getScoreInPoints();
    // Use `round()` for more precise rounding to nearest integer
    return ((scorePoints / totalPoints) * 100).round(); 
  }

  // this method recursively calls toJson() on its list properties (questions and answers).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toJson()).toList(), // Map List<Question> to List<Map>
      'answers': answers.map((a) => a.toJson()).toList(),     // Map List<Answer> to List<Map>
    };
  }
}
