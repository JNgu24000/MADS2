import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';

import '../widgets/filteredDisplay.dart';
import '../widgets/orderedDisplay.dart';

class QueryWorkout extends StatelessWidget {
  QueryWorkout({Key? key}) : super(key: key);

  final DatabaseHandler db = DatabaseHandler();
  final _formKey = GlobalKey<FormState>();
  final _workout = TextEditingController();
  final _field = TextEditingController();

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
                      child: const Text("Query")),
                  TextFormField(
                    controller: _field,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter a field (exercise or date)",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _sort(context);
                        }
                      },
                      child: const Text("Sort")),
                ]))));
  }

  void _query(BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sorted by workout')));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => filteredDisplay(workout: _workout.text)));
  }

  void _sort(BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sorted by category')));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => orderedDisplay(field: _field.text)));
  }
}
