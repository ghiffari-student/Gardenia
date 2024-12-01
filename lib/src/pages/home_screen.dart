import 'package:flutter/material.dart';
import 'package:myapp/src/models/post_model.dart';
import 'package:myapp/src/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy data untuk posts
  final List<Post> _posts = [
    Post(
        id: 1,
        userId: 1,
        title: 'Tanaman Pertamaku',
        content: 'Hari ini saya berhasil menanam lidah buaya pertama saya!',
        imageUrl:
            'https://fastly.picsum.photos/id/19/2500/1667.jpg?hmac=7epGozH4QjToGaBf_xb2HbFTXoV5o8n_cYzB7I4lt6g',
        viewsCount: 10,
        createdAt: DateTime.now()),
    Post(
        id: 2,
        userId: 2,
        title: 'Tips Merawat Kaktus',
        content: 'Kaktus membutuhkan sedikit air dan banyak cahaya matahari.',
        imageUrl:
            'https://fastly.picsum.photos/id/18/2500/1667.jpg?hmac=JR0Z_jRs9rssQHZJ4b7xKF82kOj8-4Ackq75D_9Wmz8',
        viewsCount: 25,
        createdAt: DateTime.now().subtract(const Duration(days: 1))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tanaman Sosial',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Ahmad",
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
                        icon: Icon(Icons.favorite_border,
                            color: Colors.green[700]),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
