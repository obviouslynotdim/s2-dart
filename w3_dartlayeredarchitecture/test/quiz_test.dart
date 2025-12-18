import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

const String testUserId = 'test-player-1';

main() {
  // Create 2 questions and the quiz
  Question q1 = Question(title: "2+2", choices: ["1", "2", "4"], goodChoice: "4", points: 50);
  Question q2 = Question(title: "2+3", choices: ["1", "2", "5"], goodChoice: "5", points: 50);

  Quiz quiz = Quiz(questions: [q1, q2]);

  test('All answers are good (100%)', () {
    // Create the answers
    Answer a1 = Answer(questionId: q1.id, answerChoice: "4", userId: testUserId);
    Answer a2 = Answer(questionId: q2.id, answerChoice: "5", userId: testUserId);

    quiz.answers.clear();
    quiz.answers.addAll([a1, a2]);

    // Check score percentage for the test user
    expect(quiz.getScoreInPercentage(testUserId), equals(100));
  });

  test('One answer wrong (50%)', () {
    Answer a1 = Answer(questionId: q1.id, answerChoice: "4", userId: testUserId);
    Answer a2 = Answer(questionId: q2.id, answerChoice: "1", userId: testUserId);

    quiz.answers.clear();
    quiz.answers.addAll([a1, a2]);

    expect(quiz.getScoreInPercentage(testUserId), equals(50));
  });

  test('All answers wrong (0%)', () {
    Answer a1 = Answer(questionId: q1.id, answerChoice: "2", userId: testUserId);
    Answer a2 = Answer(questionId: q2.id, answerChoice: "1", userId: testUserId);

    quiz.answers.clear();
    quiz.answers.addAll([a1, a2]);

    expect(quiz.getScoreInPercentage(testUserId), equals(0));
  });
}
