import 'package:flutter/material.dart';
import 'package:flutter_sinav_uygulamasi/models/category.dart';
import 'package:flutter_sinav_uygulamasi/pages/quiz_page.dart';

class AddQuiz extends StatefulWidget {

  final CategoryModel categoryModel;

  const AddQuiz({Key key, this.categoryModel}) : super(key: key);

  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: titleController,
                    ),
                  ),
                  RadioListTile(
                      value: 0,
                      title: TextField(
                        controller: oneController,
                      ),
                      groupValue: groupValue,
                      onChanged: (t) {
                        setState(() {
                          groupValue = 0;
                        });
                      }),
                  RadioListTile(
                      value: 1,
                      title: TextField(
                        controller: twoController,
                      ),
                      groupValue: groupValue,
                      onChanged: (t) {
                        setState(() {
                          groupValue = 1;
                        });
                      }),
                  RadioListTile(
                      value: 2,
                      title: TextField(
                        controller: threeController,
                      ),
                      groupValue: groupValue,
                      onChanged: (t) {
                        setState(() {
                          groupValue = 2;
                        });
                      }),
                  RadioListTile(
                    value: 3,
                    title: TextField(
                      controller: fourController,
                    ),
                    groupValue: groupValue,
                    onChanged: (t) {
                      setState(() {
                        groupValue = 3;
                      });
                    },
                  ),
                ],),

                    Column(
                      children: [
                        TextButton (
                            onPressed: () {
                              List<String> all =[];
                              all.add(oneController.text);
                              all.add(twoController.text);
                              all.add(threeController.text);
                              all.add(fourController.text);
                              var correct = all[groupValue];
                              all.removeAt(groupValue);
                              QuizModel quizModel = QuizModel(
                                name: titleController.text,
                                correct: correct,
                                incorrect: all,
                              );
                              print(all);
                             widget.categoryModel.quizList.add(quizModel);
                             oneController.clear();
                             twoController.clear();
                             threeController.clear();
                             fourController.clear();
                             titleController.clear();
                            },
                            child: Text("ADD"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.withOpacity(0.2)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                            )
                        ),
                        TextButton (
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => QuizPage(
                                quizList: widget.categoryModel.quizList,
                              )));
                            },
                            child: Text("START"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.withOpacity(0.2)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                            )
                        ),
                      ],
                    ),
              ],
            ),
          ),
      ),
    );
  }
}
