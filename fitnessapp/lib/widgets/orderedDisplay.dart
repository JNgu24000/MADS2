import 'package:flutter/material.dart';
import 'package:fitnessapp/models/database.dart';
import 'package:fitnessapp/models/exercise.dart';

class orderedDisplay extends StatefulWidget {
  final String field;
  orderedDisplay({Key? key, required this.field}) : super(key: key);

  @override
  State<orderedDisplay> createState() => _orderededDisplayState(field);
}

class _orderededDisplayState extends State<orderedDisplay> {
  late DatabaseHandler handler;
  final String field;
  _orderededDisplayState(this.field);

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
        future: handler.orderWorkouts(field),
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
                  key: ValueKey<int>(snapshot.data![index].id),
                  onDismissed: (DismissDirection direction) async {
                    await handler.deleteWorkout(snapshot.data![index].id);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Column(
                      children: [
                        Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Text(snapshot.data![index].date.toString()),
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
