class User {
  final String displayName;
  final String message;
  final String profilePic;
  final String time;

  User(
      {required this.displayName,
      required this.message,
      required this.profilePic,
      required this.time});

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
        displayName: json['name'],
        message: json['message'],
        profilePic: json["profilePic"],
        time: json["time"]);
  }
  Map<String, Object?> toJson() {
    return {"display_name": displayName, "message": message};
  }
}
