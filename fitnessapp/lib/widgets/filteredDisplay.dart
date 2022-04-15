import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';
import 'package:fitnessapp/models/exercise.dart';

class filteredDisplay extends StatefulWidget {
  final String workout;
  filteredDisplay({Key? key, required this.workout}) : super(key: key);

  @override
  State<filteredDisplay> createState() => _filteredDisplayState(workout);
}

class _filteredDisplayState extends State<filteredDisplay> {
  late DatabaseHandler handler;
  final String workout;
  _filteredDisplayState(this.workout);

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.searchWorkouts(workout),
        builder: (BuildContext context, AsyncSnapshot<List<Workout>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data![index].id!),
                  onDismissed: (DismissDirection direction) async {
                    await handler.deleteWorkout(snapshot.data![index].id!);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Column(
                      children: [
                        Text(snapshot.data![index].date.toString()),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Text(snapshot.data![index].exercise.toString()),
                        Text(snapshot.data![index].duration.toString()),
                      ],
                    ),
                  )),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
