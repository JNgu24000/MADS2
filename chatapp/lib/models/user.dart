class User {
  final String id;
  final String displayName;
  final String name;
  final String email;
  final String profilePic;
  final String role;

  User({
    required this.id,
    required this.displayName,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.role,
  });

  User.fromJson(String id, Map<String, dynamic> json)
      : this(
            id: id,
            displayName: json["display_name"],
            name: json["name"],
            email: json["email"],
            profilePic: json["profilePic"],
            role: json["role"]);

  Map<String, dynamic?> toJson() {
    return {
      "display_name": displayName,
      "name": name,
      "email": email,
      "profilePic": profilePic,
      "role": role
    };
  }
}
