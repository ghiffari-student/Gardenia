import 'package:myapp/src/models/user_model.dart';

class Post {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String? imageUrl;
  final int viewsCount;
  final DateTime createdAt;
  final User user;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.user,
    this.imageUrl,
    this.viewsCount = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: int.parse(json['id']),
        userId: int.parse(json['user_id']),
        title: json['title'],
        content: json['content'],
        imageUrl: json['image_url'],
        viewsCount: int.parse(json['views_count']) ?? 0,
        createdAt: DateTime.parse(json['created_at']),
        user: User.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'views_count': viewsCount,
      'created_at': createdAt.toIso8601String(),
      'user': user.toJson()
    };
  }
}
