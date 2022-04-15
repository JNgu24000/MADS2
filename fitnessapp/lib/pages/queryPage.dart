import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';

import '../widgets/filteredDisplay.dart';

class QueryWorkout extends StatelessWidget {
  QueryWorkout({Key? key}) : super(key: key);

  final DatabaseHandler db = DatabaseHandler();
  final _formKey = GlobalKey<FormState>();
  final _workout = TextEditingController();
  final workoutType = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Query Page"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: _workout,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Workout",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _query(context);
                        }
                      },
                      child: const Text("Submit")),
                ]))));
  }

  void _query(BuildContext context) async {
    final workout = _workout.text;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sorted by workout')));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => filteredDisplay(workout: _workout.text)));
  }
}
