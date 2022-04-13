import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';
import 'package:fitnessapp/models/exercise.dart';

class DatabaseDisplay extends StatefulWidget {
  const DatabaseDisplay({Key? key}) : super(key: key);

  @override
  State<DatabaseDisplay> createState() => _DatabaseDisplayState();
}

class _DatabaseDisplayState extends State<DatabaseDisplay> {
  late DatabaseHandler handler;

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
        future: handler.getWorkouts(),
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
                    title: Text(snapshot.data![index].day),
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
