import 'package:chatapp/screens/homepage.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ChatApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RegisterPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage(),
          '/register': (BuildContext context) => new RegisterPage(),
        });
  }
}
