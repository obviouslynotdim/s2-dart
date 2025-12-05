import 'package:flutter/material.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/question_screen.dart';
import 'ui/screens/result_screen.dart';
import 'data/repositories/quiz_mock_repository.dart';
import 'models/quiz.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String _activeScreen = 'welcome-screen'; 
  final List<QuizQuestion> _questions = QuizMockRepository().loadQuestions(); 
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int> _selectedAnswers = []; 

  void _startQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswers = [];
      _activeScreen = 'question-screen';
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswers = [];
      _activeScreen = 'welcome-screen';
    });
  }

  void _answerQuestion(int answerIndex) {
    _selectedAnswers.add(answerIndex);

    if (answerIndex == _questions[_currentQuestionIndex].correctIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    if (_activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        questions: _questions,
        index: _currentQuestionIndex,
        onAnswerSelected: _answerQuestion,
      );
    } else if (_activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        questions: _questions,
        selectedAnswers: _selectedAnswers,
        score: _score,
        onRestartQuiz: _restartQuiz,
      );
    } else {
      screenWidget = WelcomeScreen(startQuiz: _startQuiz);
    }
    
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: screenWidget, 
    );
  }
}