import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/src/core/api.dart';
import 'package:myapp/src/models/comment_model.dart';
import 'package:myapp/src/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  Future<List<CommentModel>> getAllComments(int postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = await prefs.getString('token');
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await http.get(Uri.parse("${commentsUrl}/post/$postId"),
          headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List posts = body['comments'];
        final List<CommentModel> data = [];
        posts.forEach(
          (element) => data.add(CommentModel.fromJson(element)),
        );
        return data;
      }
      if (response.statusCode == 404) {
        return [];
      }
      throw Exception("${response.body}");
    } catch (e) {
      print('Error fetching Comment: $e');
      throw e;
    }
  }

  Future<bool> createComment(
      {required String postId,
      required String userId,
      required String content}) async {
    final prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = {
      "post_id": postId,
      "user_id": userId,
      'content': content,
    };
    try {
      final response = await http.post(Uri.parse(commentsUrl),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        return true;
      }

      print(response);
      return false;
    } catch (e) {
      print('Comment error: $e');
      return false;
    }
  }
}
