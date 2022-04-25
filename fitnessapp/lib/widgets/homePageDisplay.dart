import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';
import 'package:fitnessapp/models/exercise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/pages/landingPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePageDisplay extends StatelessWidget {
  HomePageDisplay({Key? key}) : super(key: key);

  final DatabaseHandler db = DatabaseHandler();
  final _formKey = GlobalKey<FormState>();
  final _date = TextEditingController();
  final _exercise = TextEditingController();
  final _duration = TextEditingController();
  final _workoutID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            const Text("FitApp Home"),
            ElevatedButton(
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
            ),
          ]),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: [
          Form(
            child: Column(children: [
              TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Workout Entry Number",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  controller: _workoutID),
              TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Date (YYYY-MM-DD)",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  controller: _date,
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
                      hintText: "Duration (minutes:seconds or reps)",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  controller: _duration),
              ElevatedButton(
                  onPressed: () {
                    _submit(context);
                  },
                  child: const Text("Submit")),
              ElevatedButton(
                  onPressed: () {
                    _update(context);
                  },
                  child: const Text("Update")),
            ]),
          ),
        ])));
  }

  void _submit(BuildContext context) async {
    Workout newWorkout = Workout(
        id: int.parse(_workoutID.text),
        date: _date.text,
        exercise: _exercise.text,
        duration: _duration.text);
    await db.insertWorkouts(newWorkout);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information added to database.')));
  }

  void _update(BuildContext context) async {
    Workout newWorkout = Workout(
        id: int.parse(_workoutID.text),
        date: _date.text,
        exercise: _exercise.text,
        duration: _duration.text);
    await db.updateWorkouts(newWorkout);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information updated to database.')));
  }

  void _signOut(BuildContext context) async {
    await db.close();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signed Out.")));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }
}
