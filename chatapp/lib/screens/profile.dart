import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _displayName = TextEditingController();
  final _profilePic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Page"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const Text("Profile Customization"),
                  TextFormField(
                    controller: _displayName,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Display Name",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Profile Picture",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.black)),
                    controller: _profilePic,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _update(context);
                        }
                      },
                      child: const Text("Submit")),
                ]))));
  }

  void _update(BuildContext context) async {
    try {
      await _db.collection("users").doc(_auth.currentUser!.uid).set(
          {"displayName": _displayName.text, "profilePic": _profilePic.text},
          SetOptions(merge: true));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile updated.")));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Unknown error")));
    }
  }
}
