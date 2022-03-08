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
    return ConversationProvider(user: _auth);
  }
}
