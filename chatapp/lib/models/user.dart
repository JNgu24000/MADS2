class User {
  final String id;
  final String displayName;
  final String email;
  User({
    required this.id,
    required this.displayName,
    required this.email,
  });

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
        id: json['id'], displayName: json['name'], email: json['email']);
  }
  Map<String, Object?> toJson() {
    return {"display_name": displayName, "email": email};
  }
}
