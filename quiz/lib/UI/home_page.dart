import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz/Models/category.dart';
import 'package:quiz/Models/quiz.dart';
import 'package:quiz/Services/category_service.dart';
import 'package:quiz/UI/pages.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var difficulty = Difficulty.Easy;
  final CategoryService _categoryService = CategoryService();

  bool isLoading = false;
  bool isOpen = false;
  Categories? categories;

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

    _categoryService.getCategoriesList().then((response) {
      setState(() {
        isLoading = false;
        categories = response.data;
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          left: size.width * 0.2,
          top: size.height * 0.1,
          right: size.width * 0.2,
          bottom: size.height * 0.05,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount:
              categories == null ? 0 : categories!.triviaCategories!.length,
          itemBuilder: (BuildContext ctx, index) {
            return categories == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (builder) => SizedBox(
                          height: size.height * 0.3,
                          width: size.width * 0.2,
                          child: AlertDialog(
                            title: const Text('Choose Dificulties'),
                            content: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: Difficulty.Easy,
                                        groupValue: difficulty,
                                        onChanged: (val) {
                                          setState(() {
                                            difficulty = Difficulty.Easy;
                                          });
                                        },
                                      ),
                                      const Text('Easy')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: Difficulty.Medium,
                                        groupValue: difficulty,
                                        onChanged: (val) {
                                          setState(() {
                                            difficulty = Difficulty.Medium;
                                          });
                                        },
                                      ),
                                      const Text('Medium')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: Difficulty.Hard,
                                        groupValue: difficulty,
                                        onChanged: (val) {
                                          setState(() {
                                            difficulty = Difficulty.Hard;
                                          });
                                        },
                                      ),
                                      const Text('Hard')
                                    ],
                                  ),
                                ],
                              );
                            }),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushNamed(QuizPage.routeName);
                                  setState(() {});
                                },
                                child: const Text('Start Quiz!'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.3,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.black,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        categories!.triviaCategories![index].name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
