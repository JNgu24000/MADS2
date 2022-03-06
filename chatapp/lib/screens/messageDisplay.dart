import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class conversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildInput(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInput() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              // Edit text
              Flexible(
                child: Container(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        autofocus: true,
                        maxLines: 5,
                        controller: textEditingController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type your message...',
                        ),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.send, size: 25),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        ),
        width: double.infinity,
        height: 100.0);
  }
}
