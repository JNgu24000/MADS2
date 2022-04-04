import 'package:flutter/material.dart';
import 'package:fitnessapp/pages/landingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FitnessApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage());
  }
}
