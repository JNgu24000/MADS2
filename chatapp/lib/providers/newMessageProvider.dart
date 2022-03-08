import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/newMessageScreen.dart';

class NewMessageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Chatter>>.value(
      value: Database.streamUsers(),
      initialData: [],
      child: NewMessageScreen(),
    );
  }
}
