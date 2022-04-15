import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fitnessapp/models/exercise.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'exercise.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE workouts "
            "(id INTEGER PRIMARY KEY, "
            "date TEXT, "
            "exercise TEXT, "
            "duration TEXT)");
      },
      version: 5,
    );
  }

  Future<int> insertWorkouts(Workout workout) async {
    final Database db = await initializeDB();
    return db.insert('workouts', workout.toMap());
  }

  Future<List<Workout>> getWorkouts() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('workouts');

    return List.generate(maps.length, (i) {
      return Workout(
          id: maps[i]['id'],
          date: maps[i]['date'],
          exercise: maps[i]['exercise'],
          duration: maps[i]['duration']);
    });
  }

  Future<void> updateWorkouts(Workout workout) async {
    final Database db = await initializeDB();
    await db.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  Future<void> deleteWorkout(int id) async {
    final Database db = await initializeDB();
    await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final Database db = await initializeDB();
    db.close();
  }
}
