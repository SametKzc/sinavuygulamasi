import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sinav_uygulamasi/models/category.dart';

class QuizPage extends StatefulWidget {
  final List<QuizModel> quizList;

  const QuizPage({Key key, this.quizList}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> allAnswers = [];
  int questionNo = 0;
  Timer timer;
  int time = 20;
  int scores = 0;
  starTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (time < 1) {
          t.cancel();
          nextQuestion();
        } else {
          time = time - 1;
        }
      });
    });
  }

  nextQuestion([int option]) {
    timer.cancel();

    if (option != null &&
        allAnswers[option] == widget.quizList[questionNo].correct) {
      scores++;
    }

    if (questionNo < widget.quizList.length - 1) {
      questionNo++;
      allAnswers = [];
      allAnswers.add(widget.quizList[questionNo].correct);
      allAnswers.addAll(widget.quizList[questionNo].incorrect);
      allAnswers.shuffle();
      time = 20;
      starTimer();
    } else {
      timer.cancel();
      showResult();
    }
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(
          "Correct $scores",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          TextButton( child: Text("CANCEL"),onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          ),
          TextButton(
              child: Text("RETRY"),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => QuizPage(
                          quizList: widget.quizList,
                        )));
              },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    allAnswers.add(widget.quizList[0].correct);
    allAnswers.addAll(widget.quizList[0].incorrect);
    allAnswers.shuffle();
    starTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${questionNo + 1}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "$time",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  widget.quizList[questionNo].name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        nextQuestion(0);
                      },
                      child: Text(allAnswers[0]),
                    ),
                    TextButton(
                      onPressed: () {
                        nextQuestion(1);
                      },
                      child: Text(allAnswers[1]),
                    ),
                    TextButton(
                      onPressed: () {
                        nextQuestion(2);
                      },
                      child: Text(allAnswers[2]),
                    ),
                    TextButton(
                      onPressed: () {
                        nextQuestion(3);
                      },
                      child: Text(allAnswers[3]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
