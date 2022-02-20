import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _display = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _display, validator: (String? value) {}),
                    TextFormField(controller: _email),
                    TextFormField(
                        controller: _password,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) {
                            return "Passwords cannot be empty";
                          } else if (value.length > 7) {
                            return "Password must be minimum length of eight characters.";
                          }
                        }),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _register(context);
                          }
                        },
                        child: const Text("Register")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text("Login")),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Forgot password?")),
                  ],
                ))));
  }

  void _register(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Email already registered, please choose another or login.")));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter a stronger password.")));
      }
      return;
    }

    try {
      await _db.collection("users").doc(_auth.currentUser!.uid).set({
        "display_name": _display.text,
        "email": _email.text,
        "role": "USER"
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Unknown error")));
    }
  }

  void _login(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("User was not found, please enter a valid username")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password was incorrect, try again.")));
      }
      return;
    }
    try {
      await _db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set({"display_name": _display.text, "email": _email.text});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Unknown error")));
    }
  }
}
