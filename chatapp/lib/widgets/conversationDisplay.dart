import 'package:chatapp/models/user.dart';
import 'package:chatapp/screens/messageDisplay.dart';
import 'package:chatapp/screens/convoListView.dart';
import 'package:flutter/material.dart';

class conversationDisplay extends StatefulWidget {
  @override
  _conversationList createState() => _conversationList();
}

class _conversationList extends State<conversationDisplay> {
  List<User> chatUsers = [
    User(
        displayName: "AshenDemon17",
        message: "Let the lesson begin!",
        profilePic:
            "https://ssb.wiki.gallery/images/thumb/c/cc/Byleth-Alt1_SSBU.png/500px-Byleth-Alt1_SSBU.png",
        time: "18 Jan"),
    User(
        displayName: "LimitBreaker7",
        message: "Where's Sephiroth?",
        profilePic:
            "https://ssb.wiki.gallery/images/thumb/e/e7/Cloud-Alt1_SSBU.png/500px-Cloud-Alt1_SSBU.png",
        time: "18 Dec"),
    User(
        displayName: "TheAegis2",
        message: "Think you can take me?",
        profilePic: "https://ssb.wiki.gallery/images/2/26/SSBUMythraTaunt3.gif",
        time: "24 Mar"),
    User(
        displayName: "RadiantHero10",
        message: "We'll see each other soon.",
        profilePic:
            "https://ssb.wiki.gallery/images/thumb/9/99/IkeVictoryPose1SSBU.gif/240px-IkeVictoryPose1SSBU.gif",
        time: "7 April"),
    User(
        displayName: "OneWingedAngel07",
        message: "I..will never be a memory.",
        profilePic:
            "https://ssb.wiki.gallery/images/9/9d/SephirothVictoryPose1SSBU.gif",
        time: "7 July"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Messages",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDetailPage()));
                        },
                        child: const Text("New Message")),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationView(
                  displayName: chatUsers[index].displayName,
                  message: chatUsers[index].message,
                  profilePic: chatUsers[index].profilePic,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
