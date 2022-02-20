import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: const Text("Registration Page"),
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
                            hintText: "Email",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        controller: _email),
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
                          } else if (value.length < 7) {
                            return "Password must be minimum length of eight characters.";
                          }
                        }),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _register(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                        },
                        child: const Text("Register")),
                    const SizedBox(height: 10),
                    const Text("Already a user? Login here"),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text("Login")),
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
}
