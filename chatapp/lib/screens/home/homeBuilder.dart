import 'package:chatapp/models/convo.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/screens/profile.dart';
import 'package:chatapp/providers/newMessageProvider.dart';
import 'package:chatapp/widgets/convoWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseUser = Provider.of<FirebaseAuth>(context);
    final List<Convo> _convos = Provider.of<List<Convo>>(context);
    final List<User> _users = Provider.of<List<User>>(context);
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
        body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: getWidgets(context, firebaseUser, _convos, _users)));
  }

  void createNewConvo(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => NewMessageProvider()));
  }

  Map<String, User> getUserMap(List<User> users) {
    final Map<String, User> userMap = Map();
    for (User u in users) {
      userMap[u.uid] = u;
    }
    return userMap;
  }

  List<Widget> getWidgets(BuildContext context, FirebaseAuth user,
      List<Convo> _convos, List<User> _users) {
    final List<Widget> list = <Widget>[];
    if (_convos != null && _users != null && user != null) {
      final Map<String, User> userMap = getUserMap(_users);
      for (Convo c in _convos) {
        if (c.userIds[0] == user.currentUser!.uid) {
          list.add(ConvoListItem(
              user: user,
              peer: userMap[c.userIds[1]],
              lastMessage: c.lastMessage));
        } else {
          list.add(ConvoListItem(
              user: user,
              peer: userMap[c.userIds[0]],
              lastMessage: c.lastMessage));
        }
      }
    }

    return list;
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signed Out.")));
    Navigator.of(context).pushNamed('/register');
  }
}
