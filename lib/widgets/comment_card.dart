// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/backend/storage/firebase_post_storage.dart';
import 'package:instagram_clone/model/user.dart';
// import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final String postId;
  final snapshot;
  const CommentCard({super.key, required this.snapshot, required this.postId});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snapshot['profileUrl']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: primaryColor),
                          children: [
                        TextSpan(
                          text: widget.snapshot['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${widget.snapshot['commentText']}',
                        ),
                      ])),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snapshot['timestamp'].toDate()),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                LikeAnimation(
                  isAnimating:
                      widget.snapshot['likes'].contains(userDetails.uid),
                  smallLike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FireStorePostStorage().likesComment(
                        widget.postId,
                        userDetails.uid,
                        widget.snapshot['likes'],
                        widget.snapshot['commentId'],
                      );
                    },
                    icon: widget.snapshot['likes'].contains(userDetails.uid)
                        ? const Icon(
                            Icons.favorite,
                            size: 26,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            size: 26,
                            color: primaryColor,
                          ),
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snapshot['likes'].length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
