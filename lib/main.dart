import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void showPopUp() {
    Alert(
        context: context,
        type: AlertType.success,
        title: "YOU MADE IT!",
        desc: "You finished the questions!",
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
        ],
        style: AlertStyle(isOverlayTapDismiss: false, isCloseButton: true))
        .show();
  }

  void verifyAswer(bool answer) {
    setState(() {
      if (quizBrain.getAnswer() == answer) {
        scoreKeeper.add(Icon(Icons.done, color: Colors.green));
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
      quizBrain.nextQuestion();

      if (quizBrain.hasFinished()) {
        quizBrain.reset();
        scoreKeeper.clear();
        showPopUp();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                verifyAswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              color: Colors.red,
              onPressed: () {
                verifyAswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 10, 19),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 30,
              )
            ] +
                scoreKeeper,
          ),
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
