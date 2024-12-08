import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/src/core/api.dart';
import 'package:myapp/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var body = {
      'username': username,
      'email': email,
      'password': password,
    };
    try {
      final response = await http.post(Uri.parse(registerUrl),
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

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var body = {
      'email': email,
      'password': password,
    };
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: jsonEncode(body),
        headers: headers,
      );

      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(result['user']);
        await _saveToken(result['token'], user);
        return user;
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<void> _saveToken(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token') && prefs.containsKey('user');
  }
}
