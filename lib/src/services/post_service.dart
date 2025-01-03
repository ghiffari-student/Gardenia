import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/src/core/api.dart';
import 'package:myapp/src/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  Future<List<Post>> getAllPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = await prefs.getString('token');
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await http.get(Uri.parse(postUrl), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List posts = body['posts'];
        final List<Post> data = [];
        posts.forEach(
          (element) => data.add(Post.fromJson(element)),
        );
        return data;
      }
      throw Exception();
    } catch (e) {
      print('Error fetching posts: $e');
      throw e;
    }
  }

  Future<bool> createPost({
    required String title,
    required String content,
    File? imageFile,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = {
      'title': title,
      'content': content,
    };
    try {
      final response = await http.post(Uri.parse(postUrl),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        return true;
      }

      print(response);
      return false;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }
}
