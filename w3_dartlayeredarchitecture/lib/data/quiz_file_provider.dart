import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizFileProvider {
  final String filePath;

  QuizFileProvider(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content) as Map<String, dynamic>;

    // Read questions
    var questionsJson = data['questions'] as List<dynamic>;
    var questions = questionsJson.map((q) {
      return Question(
        id: q['id'],
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        points: q['points'],
      );
    }).toList();

    // Read answers
    var answersJson = data['answers'] as List<dynamic>? ?? [];
    var answers = answersJson.map((a) {
      return Answer(
        id: a['id'],
        questionId: a['questionId'],
        answerChoice: a['answerChoice'],
        userId: a['userId'],
      );
    }).toList();

    return Quiz(questions: questions, answers: answers);
  }

  void writeQuiz(Quiz quiz) {
    final data = quiz.toJson();
    final file = File(filePath);
    file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));
  }
}
