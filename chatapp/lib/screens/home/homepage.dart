import 'package:chatapp/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/providers/conversationProvider.dart';

class HomePage extends StatefulWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text("ChatApp"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: const Text("Edit Profile")),
                ElevatedButton(
                    onPressed: () async {
                      _signOut(context);
                    },
                    child: const Text("Logout"))
              ],
            )),
        body: ConversationProvider(user: _auth));
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signed Out.")));
    Navigator.of(context).pushNamed('/register');
  }
}
