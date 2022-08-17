import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz/Services/quiz_service.dart';
import 'package:quiz/UI/home_page.dart';

import '../Models/quiz.dart';

class QuizPage extends StatefulWidget {
  static const String routeName = '/quiz';
  final int categoryId;
  final String difficulty;
  const QuizPage({
    Key? key,
    required this.categoryId,
    required this.difficulty,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var countCorrectAnswer = 0;
  var answerAColor = Colors.white;
  var answerBColor = Colors.white;
  var answerCColor = Colors.white;
  var answerDColor = Colors.white;

  var currentIndex = 0;
  var totalQuestions = 0;

  final QuizService _quizService = QuizService();

  bool isLoading = false;
  bool isOpen = false;
  Quiz? quiz;
  List<Result> quizResultList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadCategories();
  }

  void loadCategories() {
    setState(() {
      isLoading = true;
    });

    _quizService
        .getQuizList(widget.categoryId, widget.difficulty.toLowerCase())
        .then((response) {
      setState(() {
        isLoading = false;
        quiz = response.data;
        quizResultList = quiz!.results!;
        totalQuestions = quizResultList.length;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: '$error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  nextQuestion() {
    if (currentIndex < totalQuestions - 1) {
      setState(() {
        currentIndex++;
      });
      print(currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                'Current Question: ${currentIndex + 1}/${quizResultList.length}'),
            Text(
                'Correct Answer: $countCorrectAnswer/${quizResultList.length}'),
            Container(
              height: size.height * 0.8,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.grey, width: 1.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.black.withAlpha(10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(30.0),
              child: quiz == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    )
                  : quiz!.results!.isEmpty
                      ? const Center(
                          child: Text('No any questions available!'),
                        )
                      : buildQuesionContainer(size),
            ),
          ],
        ),
      ),
    );
  }

  Column buildQuesionContainer(Size size) {
    var answerList = quizResultList[currentIndex].incorrectAnswers!;
    answerList.add(quizResultList[currentIndex].correctAnswer!);
    var tempList = (answerList.toSet().toList()..shuffle()).take(4).toList();
    var randomList = tempList;
    print(answerList);
    print(randomList);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(quizResultList[currentIndex].question!),
        const SizedBox(
          height: 30.0,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (randomList[0] ==
                    quizResultList[currentIndex].correctAnswer) {
                  setState(() {
                    countCorrectAnswer++;
                    answerAColor = Colors.green;
                  });
                } else {
                  if (randomList[1] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerBColor = Colors.green;
                    });
                  } else if (randomList[2] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerCColor = Colors.green;
                    });
                  } else if (randomList[3] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerDColor = Colors.green;
                    });
                  }
                  setState(() {
                    answerAColor = Colors.red;
                  });
                }
                onClick(size);
              },
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: answerAColor,
                ),
                alignment: Alignment.center,
                child: Text(randomList[0]),
              ),
            ),
            SizedBox(
              width: size.width * 0.1,
            ),
            GestureDetector(
              onTap: () {
                if (randomList[1] ==
                    quizResultList[currentIndex].correctAnswer) {
                  setState(() {
                    countCorrectAnswer++;
                    answerBColor = Colors.green;
                  });
                } else {
                  if (randomList[0] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerAColor = Colors.green;
                    });
                  } else if (randomList[2] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerCColor = Colors.green;
                    });
                  } else if (randomList[3] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerDColor = Colors.green;
                    });
                  }
                  setState(() {
                    answerBColor = Colors.red;
                  });
                }
                onClick(size);
              },
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: answerBColor,
                ),
                alignment: Alignment.center,
                child: Text(randomList[1]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (randomList[2] ==
                    quizResultList[currentIndex].correctAnswer) {
                  setState(() {
                    countCorrectAnswer++;
                    answerCColor = Colors.green;
                  });
                } else {
                  if (randomList[0] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerAColor = Colors.green;
                    });
                  } else if (randomList[1] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerBColor = Colors.green;
                    });
                  } else if (randomList[3] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerDColor = Colors.green;
                    });
                  }
                  setState(() {
                    answerCColor = Colors.red;
                  });
                }
                onClick(size);
              },
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: answerCColor,
                ),
                alignment: Alignment.center,
                child: Text(randomList[2]),
              ),
            ),
            SizedBox(
              width: size.width * 0.1,
            ),
            GestureDetector(
              onTap: () {
                if (randomList[3] ==
                    quizResultList[currentIndex].correctAnswer) {
                  setState(() {
                    countCorrectAnswer++;
                    answerDColor = Colors.green;
                  });
                } else {
                  if (randomList[0] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerAColor = Colors.green;
                    });
                  } else if (randomList[1] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerBColor = Colors.green;
                    });
                  } else if (randomList[2] ==
                      quizResultList[currentIndex].correctAnswer) {
                    setState(() {
                      answerCColor = Colors.green;
                    });
                  }
                  setState(() {
                    answerDColor = Colors.red;
                  });
                }
                onClick(size);
              },
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: answerDColor,
                ),
                alignment: Alignment.center,
                child: Text(randomList[3]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  onClick(Size size) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) => AlertDialog(
        title: currentIndex == quizResultList.length - 1
            ? Text('Your Correct Answers')
            : null,
        content: currentIndex == quizResultList.length - 1
            ? Text(
                'Correct Answer: $countCorrectAnswer/${quizResultList.length}')
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  answerAColor = Colors.white;
                  answerBColor = Colors.white;
                  answerCColor = Colors.white;
                  answerDColor = Colors.white;
                  build(context);
                  currentIndex++;
                  setState(() {});
                },
                child: Text('NEXT QUESION'),
              ),
        actions: currentIndex == quizResultList.length - 1
            ? [
                TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(HomePage.routeName),
                    child: Text('Okay!')),
              ]
            : null,
      ),
    );
  }
}
