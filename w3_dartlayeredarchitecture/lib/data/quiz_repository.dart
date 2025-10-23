import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('Quiz file not found at $filePath');
    }

    final content = file.readAsStringSync();
    final data = jsonDecode(content) as Map<String, dynamic>;

    // 1. Map JSON to Question objects
    var questionsJson = data['questions'] as List<dynamic>;
    var questions = questionsJson.map((q) {
      // Ensure the 'q' map is treated as Map<String, dynamic>
      final qMap = q as Map<String, dynamic>;
      return Question(
        id: qMap['id'] as String, // Read the ID
        title: qMap['title'] as String,
        choices: List<String>.from(qMap['choices'] as List<dynamic>),
        goodChoice: qMap['goodChoice'] as String,
        points: qMap['points'] as int,
      );
    }).toList();

    // 2. Map JSON to Answer objects (submissions)
    List<Answer> answers = [];
    if (data.containsKey('answers')) {
      var answersJson = data['answers'] as List<dynamic>;
      answers = answersJson.map((a) {
        final aMap = a as Map<String, dynamic>;
        return Answer(
          id: aMap['id'] as String, // Read the ID
          questionId: aMap['questionId'] as String, // Read the questionId
          answerChoice: aMap['answerChoice'] as String,
        );
      }).toList();
    }

    // 3. Create the Quiz object, including its ID and the answers
    return Quiz(
      id: data['id'] as String, // Read the Quiz ID
      questions: questions,
      answers: answers, // Include the loaded answers/submissions
    );
  }
}

// i use some AI for Question4 because this one is new to me!!!