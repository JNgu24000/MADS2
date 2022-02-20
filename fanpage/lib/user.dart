class User {
  final String id;
  final String displayName;
  final String first_name;
  final String last_name;
  final String email;
  final String role;

  User({
    required this.id,
    required this.displayName,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.role,
  });

  User.fromJson(String id, Map<String, dynamic> json)
      : this(
            id: id,
            displayName: json["display_name"],
            first_name: json["first_name"],
            last_name: json["last_name"],
            email: json["email"],
            role: json["role"]);

  Map<String, dynamic?> toJson() {
    return {
      "display_name": displayName,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "role": role
    };
  }
}
