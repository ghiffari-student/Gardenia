import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/src/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  static const String _baseUrl = 'http://your-api-domain.com/api/posts';

  Future<List<Post>> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((post) => Post.fromJson(post)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Future<Post?> createPost({
    required String title,
    required String content,
    File? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');

      if (userId == null) return null;

      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
      request.fields['user_id'] = userId;
      request.fields['title'] = title;
      request.fields['content'] = content;

      if (imageFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imageFile.path));
      }

      final response = await request.send();
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        return Post.fromJson(json.decode(responseBody));
      }
      return null;
    } catch (e) {
      print('Error creating post: $e');
      return null;
    }
  }
}
