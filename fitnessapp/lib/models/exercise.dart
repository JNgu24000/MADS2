class Workout {
  final int? id;
  final String day;
  final String exercise;
  final String duration;

  const Workout(
      {this.id,
      required this.day,
      required this.exercise,
      required this.duration});

  Map<String, dynamic> toMap() {
    return {'id': id, 'day': day, 'exercise': exercise, 'duration': duration};
  }

  @override
  String toString() {
    return 'Workout{id:$id,day:$day,exercise:$exercise,duration:$duration}';
  }
}
