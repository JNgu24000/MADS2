import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_application_1/user.dart';

User? myself;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome!"),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: myself != null && myself!.role == "ADMIN"
            ? FloatingActionButton(onPressed: () {})
            : null,
        body: Center(
            child: Form(
                child: Column(
          children: [
            ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Logout Confirmation'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage())),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text("Logout"),
            )
          ],
        ))));
  }
}
