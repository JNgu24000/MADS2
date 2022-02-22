import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _display = TextEditingController();
  var _password = TextEditingController();

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
                            hintText: "Email",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        controller: _email,
                        validator: (String? value) {
                          if (value == null) {
                            return "Please enter an email";
                          }
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
                          if (value == null) {
                            return "Passwords cannot be empty";
                          }
                        }),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login(context);
                          }
                        },
                        child: const Text("Login")),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Forgot password?")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: const Text("Back to Registration")),
                  ],
                ))));
  }

  void _login(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "No username associated with email entered, please register.")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password was incorrect, try again.")));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
