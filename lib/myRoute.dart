import 'package:flutter/material.dart';
import 'package:flutterstudy2/pages/mainPage.dart';

class MyRoute extends StatelessWidget {
  const MyRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings route){
        return MaterialPageRoute(
          settings: RouteSettings(name: MainPage.path),
          builder: (_) => MainPage()
        );
      },
    );
  }
}
