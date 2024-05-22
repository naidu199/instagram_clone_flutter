import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class PostView extends StatelessWidget {
  final snapshot;
  const PostView({super.key, this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PostCard(snapshot: snapshot)),
    );
  }
}
