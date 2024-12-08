import 'package:flutter/material.dart';
import 'package:myapp/src/core/images.dart';
import 'package:myapp/src/models/post_model.dart';
import 'package:myapp/src/models/user_model.dart';
import 'package:myapp/src/pages/login_screen.dart';
import 'package:myapp/src/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy posts
  final List<Post> _userPosts = [
    Post(
        user: User(id: 1, username: "asdasd", email: ""),
        id: 1,
        userId: 1,
        title: 'Koleksi Kaktus Baru',
        content: 'Baru saja menambah 3 kaktus baru ke koleksi!',
        imageUrl:
            'https://fastly.picsum.photos/id/25/5000/3333.jpg?hmac=yCz9LeSs-i72Ru0YvvpsoECnCTxZjzGde805gWrAHkM',
        viewsCount: 15),
    Post(
        user: User(id: 1, username: "", email: ""),
        id: 2,
        userId: 1,
        title: 'Perawatan Anggrek',
        content: 'Tips merawat anggrek agar tetap sehat dan berbunga',
        imageUrl:
            'https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA',
        viewsCount: 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout dan kembali ke login screen
              AuthService().logout();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(noProfileImage),
                    backgroundColor: Colors.green[100],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.user.username,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800]),
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(color: Colors.green[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.user.bio ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green[700]),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Postingan', _userPosts.length),
                      _buildStatColumn('Pengikut', 100),
                      _buildStatColumn('Mengikuti', 50),
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Postingan Saya',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _userPosts.length,
              itemBuilder: (context, index) {
                final post = _userPosts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: TextStyle(
                              fontSize: 16,
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
                        Text(
                          'Dilihat: ${post.viewsCount}',
                          style: TextStyle(color: Colors.green[600]),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Edit profil
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildStatColumn(String label, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.green[600]),
        )
      ],
    );
  }
}
