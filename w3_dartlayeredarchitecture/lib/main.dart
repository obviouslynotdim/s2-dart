import 'dart:io';
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_repository.dart';

void main() {
  // define path in ur JSON file
  const String quizFilePath = 'quiz_data.json';

  try {
    // instantiate the repository
    QuizRepository repository = QuizRepository(quizFilePath);

    // load the Quiz from the JSON file
    Quiz quiz = repository.readQuiz();

    print('Quiz "${quiz.id}" loaded with ${quiz.questions.length} questions.');

    // the previous questions list is now loaded from the JSON
    // the hardcoded list is no longer needed:
    // List<Question> questions = [...]

    QuizConsole console = QuizConsole(quiz: quiz);
    console.startQuiz();

    } on FileSystemException catch (e) {
    print('Error: Could not read quiz file. Make sure $quizFilePath exists.');
    print(e);
  } catch (e) {
    print('An error occurred while loading the quiz: $e');
  }
}