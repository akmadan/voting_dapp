import 'package:flutter/material.dart';
import 'package:voting_dapp/pages/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple))),
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
          appBarTheme: AppBarTheme(elevation: 0)),
      home: Home(),
    );
  }
}
