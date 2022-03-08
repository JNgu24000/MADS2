import 'package:chatapp/screens/profile.dart';
import 'package:chatapp/widgets/conversationDisplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var result = await _db.collection("users").doc(user!.uid).get().then((value){

  })

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(),
                  maxRadius: 30,
                ),
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
        body: conversationDisplay());
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signed Out.")));
    Navigator.of(context).pushNamed('/register');
  }
}
