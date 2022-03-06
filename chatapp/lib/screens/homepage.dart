import 'package:chatapp/screens/profile.dart';
import 'package:chatapp/screens/register.dart';
import 'package:chatapp/widgets/conversationList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;

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
        body: conversationList());
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signed Out.")));
    Navigator.of(context).pushNamed('/register');
  }
}
