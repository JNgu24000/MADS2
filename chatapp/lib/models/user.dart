class Chatter {
  Chatter({
    required this.id,
    required this.displayName,
    required this.profilePic,
  });

  factory Chatter.fromMap(Map<String, dynamic> data) {
    return Chatter(
        id: data['id'],
        displayName: data['name'],
        profilePic: data['profilePic']);
  }

  final String id;
  final String displayName;
  final String profilePic;
}
