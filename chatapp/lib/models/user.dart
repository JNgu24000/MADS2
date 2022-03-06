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

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        id: data['id'],
        displayName: data['displayName'],
        name: data['name'],
        email: data['email'],
        profilePic: data['profilePic'],
        role: data['role']);
  }
}
