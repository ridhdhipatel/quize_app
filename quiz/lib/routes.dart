import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/UI/pages.dart';

class PageRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case QuizPage.routeName:
        var args = settings.arguments as QuizPage;
        return MaterialPageRoute(
            builder: (_) => QuizPage(
                  categoryId: args.categoryId,
                  difficulty: args.difficulty,
                ));

      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Error')),
    );
  }
}
