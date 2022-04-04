import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _display = TextEditingController();

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
                child: Column(children: [
                  TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      controller: _email,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      controller: _password,
                      obscureText: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Passwords cannot be empty";
                        } else if (value.length < 6) {
                          return "Password must be at least six characters";
                        }
                        return null;
                      }),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _register(context);
                        }
                      },
                      child: const Text("Register")),
                ]))));
  }

  void _register(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      Navigator.of(context).pushNamed('/login');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Account Registered')));
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
  }
}
