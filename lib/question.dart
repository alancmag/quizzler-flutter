class Question {
  String _questionText;
  bool _answer;

  Question(String q, bool a) {
    _answer = a;
    _questionText = q;
  }

  String getQuestionText() => _questionText;

  bool getAnswer() => _answer;
}
