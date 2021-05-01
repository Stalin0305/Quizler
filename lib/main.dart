import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(QuizllerApp());
}

class QuizllerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: QuizBox(),
          ),
        ),
      ),
    );
  }
}

class QuizBox extends StatefulWidget {
  @override
  _QuizBoxState createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  // List<String> questions = [
  //   'You can lead a cow downstairs, but not upstairs',
  //   'Approximately one quarter of the human bones are in the feet',
  //   'A slug\'s blood is green',
  // ];
  //
  // List<bool> answers = [false, true, true];

  //List of questions before writing it in quizBrain.dart file

  // List<Question> questionAns = [
  //   Question(q: 'You can lead a cow downstairs, but not upstairs', a: false),
  //   Question(
  //       q: 'Approximately one quarter of the human bones are in the feet',
  //       a: true),
  //   Question(q: 'A slug\'s blood is green', a: true)
  // ];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAns = quizBrain.getQuestionAnswer();

    if (quizBrain.isFinished()) {
      Alert(
          context: context,
          title: 'Finished',
          desc: 'You have reached the end of the flutter application');
      quizBrain.reset();
      scoreKeeper.clear();
    } else {
      if (correctAns == userPickedAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      setState(() {
        quizBrain.nextQuestion();
      });
    }
  }

  List<Icon> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                // quizBrain.questionAns[qtrack].questionText,
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                // print(quizBrain.questionAns[0].questionText);
                // bool correctAns = quizBrain.questionAns[qtrack].questionAnswer;
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                // bool correctAns = quizBrain.questionAns[qtrack].questionAnswer;
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
