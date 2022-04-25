class Workout {
  final int id;
  final String date;
  final String exercise;
  final String duration;

  const Workout(
      {required this.id,
      required this.date,
      required this.exercise,
      required this.duration});

  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date, 'exercise': exercise, 'duration': duration};
  }

  @override
  String toString() {
    return 'Workout{id:$id,date:$date,exercise:$exercise,duration:$duration}';
  }
}
