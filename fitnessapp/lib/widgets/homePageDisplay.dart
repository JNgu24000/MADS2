import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';
import 'package:fitnessapp/models/exercise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/pages/landingPage.dart';

class HomePageDisplay extends StatelessWidget {
  HomePageDisplay({Key? key}) : super(key: key);

  final DatabaseHandler db = DatabaseHandler();
  final _formKey = GlobalKey<FormState>();
  final _day = TextEditingController();
  final _exercise = TextEditingController();
  final _duration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FitApp Home"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: [
          Align(
              alignment: const Alignment(0.9, 1),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Logout Confirmation'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          _signOut(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Text("Logout"),
              )),
          Form(
            child: Column(children: [
              TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Day",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  controller: _day,
                  validator: (String? value) {}),
              TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Exercise",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  controller: _exercise),
              TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Duration (minutes:seconds)",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  controller: _duration),
              ElevatedButton(
                  onPressed: () {
                    _submit(context);
                  },
                  child: const Text("Register")),
            ]),
          ),
        ])));
  }

  void _submit(BuildContext context) async {
    Workout newWorkout = Workout(
        day: _day.text, exercise: _exercise.text, duration: _duration.text);
    await db.insertWorkouts(newWorkout);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information added to database')));
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signed Out.")));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LandingPage()));
  }
}
