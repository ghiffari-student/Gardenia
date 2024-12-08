import 'package:flutter/material.dart';
import 'package:myapp/src/core/images.dart';
import 'package:myapp/src/models/post_model.dart';
import 'package:myapp/src/models/user_model.dart';
import 'package:myapp/src/services/comment_service.dart';

class DetailPost extends StatefulWidget {
  final Post post;
  final User user;
  const DetailPost({super.key, required this.post, required this.user});

  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  final _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage(noProfileImage)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.post.user.username}",
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
                    widget.post.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800]),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.post.content),
                  if (widget.post.imageUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.network(
                        widget.post.imageUrl!,
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
                  ),
                ],
              ),
            ),
            Divider(),
            FutureBuilder(
                future: CommentService().getAllComments(widget.post.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(noProfileImage),
                        ),
                        title: Text("${snapshot.data![index].user!.username}"),
                        subtitle: Text("${snapshot.data![index].content}"),
                      );
                    },
                  );
                }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Comment",
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final bool response = await CommentService()
                              .createComment(
                                  postId: "${widget.post.id}",
                                  userId: "${widget.user.id}",
                                  content: _commentController.text);
                          if (response) {
                            _commentController.clear();
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("Gagal")));
                          }
                        },
                        icon: Icon(Icons.send))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
