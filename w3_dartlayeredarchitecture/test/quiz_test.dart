import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

main() {
  // Create 2 questions and the quiz
  Question q1 = Question(
      title: "2+2", choices: ["1", "2", "4"], goodChoice: "4", points: 50);

  Question q2 = Question(
      title: "2+3", choices: ["1", "2", "5"], goodChoice: "5", points: 50);

  Quiz quiz = Quiz(questions: [q1, q2]);

  test('All answers are good (100%)', () {
    // Create the answer here
    Answer a1 = Answer(questionId: q1.id, answerChoice: "4");
    Answer a2 = Answer(questionId: q2.id, answerChoice: "5");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(100));
  });

  test('All answer are okay (50%)', () {
    // Create the answer here
    Answer a1 = Answer(questionId: q1.id, answerChoice: "4");
    Answer a2 = Answer(questionId: q2.id, answerChoice: "1");
    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(50));
  });

  test('All answer are not okay (0%)', () {
    // Create the answer here
    Answer a1 = Answer(questionId: q1.id, answerChoice: "2");
    Answer a2 = Answer(questionId: q2.id, answerChoice: "1");
    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(0));
  });
}
