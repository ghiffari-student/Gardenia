class User {
  final int id;
  final String username;
  final String email;
  final String? bio;
  final String? profilePicture;
  final DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.bio,
    this.profilePicture,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      bio: json['bio'],
      profilePicture: json['profile_picture'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'profile_picture': profilePicture,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
