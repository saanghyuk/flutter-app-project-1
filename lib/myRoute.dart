import 'package:flutter/material.dart';
import 'package:flutterstudy2/pages/mainPage.dart';
import 'package:flutterstudy2/providers/homeViewProvider.dart';
import 'package:provider/provider.dart';

class MyRoute extends StatelessWidget {
  const MyRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewProvider>(
            create: (_) => HomeViewProvider()
        )
      ],
      child: MaterialApp(
        onGenerateRoute: (RouteSettings route) {
          return MaterialPageRoute(
              settings: RouteSettings(name: MainPage.path),
              builder: (_) => MainPage()
          );
        },
      ),
    );
  }
}
