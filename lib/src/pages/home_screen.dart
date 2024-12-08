import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/core/images.dart';
import 'package:myapp/src/models/post_model.dart';
import 'package:myapp/src/models/user_model.dart';
import 'package:myapp/src/pages/add_post_screen.dart';
import 'package:myapp/src/pages/detail_post.dart';
import 'package:myapp/src/pages/profile_screen.dart';
import 'package:myapp/src/services/post_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy data untuk posts
  // final List<Post> _posts = [
  //   Post(
  //       id: 1,
  //       userId: 1,
  //       title: 'Tanaman Pertamaku',
  //       content: 'Hari ini saya berhasil menanam lidah buaya pertama saya!',
  //       imageUrl:
  //           'https://fastly.picsum.photos/id/19/2500/1667.jpg?hmac=7epGozH4QjToGaBf_xb2HbFTXoV5o8n_cYzB7I4lt6g',
  //       viewsCount: 10,
  //       createdAt: DateTime.now()),
  //       User(id: id, username: username, email: email)
  //   Post(
  //       id: 2,
  //       userId: 2,
  //       title: 'Tips Merawat Kaktus',
  //       content: 'Kaktus membutuhkan sedikit air dan banyak cahaya matahari.',
  //       imageUrl:
  //           'https://fastly.picsum.photos/id/18/2500/1667.jpg?hmac=JR0Z_jRs9rssQHZJ4b7xKF82kOj8-4Ackq75D_9Wmz8',
  //       viewsCount: 25,
  //       createdAt: DateTime.now().subtract(const Duration(days: 1))),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gardenia',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final userString = await prefs.getString("user");
              final user = User.fromJson(jsonDecode(userString!));
              // final user = User(id: 1, username: "adsasd", email: "adasd");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            user: user,
                          )));
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: PostService().getAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];

                return GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userString = await prefs.getString("user");
                      final user = User.fromJson(jsonDecode(userString!));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPost(
                              post: post,
                              user: user,
                            ),
                          ));
                    },
                    child: PostCard(post: post));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
          setState(() {});
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(noProfileImage)),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${post.user.username}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              post.title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800]),
            ),
            const SizedBox(height: 8),
            Text(post.content),
            if (post.imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.network(
                  post.imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.green[700]),
                  onPressed: () {
                    // TODO: Implementasi like
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.green[700]),
                  onPressed: () {
                    // TODO: Buka halaman komentar
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
