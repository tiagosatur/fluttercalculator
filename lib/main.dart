import 'package:flutter/material.dart';
import './screens/calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Calculator',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Calculator(),
        ));
  }
}
