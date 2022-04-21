import 'package:fitnessapp/widgets/databaseDisplay.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/pages/landingPage.dart';
import 'package:fitnessapp/pages/loginPage.dart';
import 'package:fitnessapp/pages/homePage.dart';
import 'package:fitnessapp/pages/registerPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home: LandingPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => LoginPage(),
          '/register': (BuildContext context) => RegisterPage(),
          '/databaseDisplay': (BuildContext context) => const DatabaseDisplay()
        });
  }
}
