import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  var _password = TextEditingController();
  var _display = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        controller: _display,
                        validator: (String? value) {}),
                    TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        controller: _password,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) {
                            return "Passwords cannot be empty";
                          }
                        }),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Login")),
                  ],
                ))));
  }
}
