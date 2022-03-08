import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/widgets/userRow.dart';

class NewMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth user = Provider.of<FirebaseAuth>(context);
    final List<Chatter> userDirectory = Provider.of<List<Chatter>>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Select Contact')),
      body: user != null && userDirectory != null
          ? ListView(
              shrinkWrap: true, children: getListViewItems(userDirectory, user))
          : Container(),
    );
  }

  List<Widget> getListViewItems(
      List<Chatter> userDirectory, FirebaseAuth user) {
    final List<Widget> list = <Widget>[];
    for (Chatter contact in userDirectory) {
      if (contact.id != user.currentUser!.uid) {
        list.add(UserRow(uid: user.currentUser!.uid, contact: contact));
        list.add(Divider(thickness: 1.0));
      }
    }
    return list;
  }
}
