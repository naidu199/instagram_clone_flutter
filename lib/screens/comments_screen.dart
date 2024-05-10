import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/backend/storage/firebase_post_storage.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:instagram_clone/widgets/text_input.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snapshot;
  const CommentsScreen({super.key, required this.snapshot});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, _) {
      final UserDetails userDetails = value.getUser;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Comments'),
          centerTitle: false,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snapshot['postId'])
              .collection('comments')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CommentCard(
                    snapshot: snapshot.data!.docs[index].data(),
                  );
                });
          },
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userDetails.profileUrl),
                radius: 18,
              ),
              //TODO: Add profile image here
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 20),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: "comment as ${userDetails.username}",
                    border: InputBorder.none,
                  ),
                ),
              )),
              InkWell(
                onTap: () async {
                  await FireStorePostStorage().postComments(
                      widget.snapshot['postId'],
                      commentController.text,
                      userDetails.uid,
                      userDetails.username,
                      userDetails.profileUrl);
                  setState(() {
                    commentController.clear();
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'post',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}
