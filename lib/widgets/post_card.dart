
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/backend/storage/firebase_post_storage.dart';
import 'package:instagram_clone/model/user.dart';
// import 'package:instagram_clone/routes/approutes.dart';
import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_consts.dart';
import 'package:instagram_clone/utils/snackbars.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snapshot;
  const PostCard({super.key, required this.snapshot});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentsLength = 0;
  @override
  void initState() {
    super.initState();
    getAllComments();
  }

  void getAllComments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snapshot['postId'])
          .collection('comments')
          .get();
      setState(() {
        commentsLength = querySnapshot.docs.length;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final UserDetails userDetails = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      NetworkImage(widget.snapshot['profileImage']),
                ),
                InkWell(
                  onTap: () => width > webscreensize
                      ? showBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: DraggableScrollableSheet(
                                maxChildSize: 1,
                                initialChildSize: 1,
                                minChildSize: 0.2,
                                builder: (context, scrollController) {
                                  return ProfileScreen(
                                      uid: widget.snapshot['uid']);
                                },
                              ),
                            );
                          },
                        )
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(uid: widget.snapshot['uid']),
                          ),
                        ),
                  child: Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.snapshot['username'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SizedBox(
                                width: 250,
                                child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: ['Delete']
                                      .map((e) => InkWell(
                                            onTap: () async {
                                              FireStorePostStorage().deletePost(
                                                  widget.snapshot['postId'],
                                                  context);
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: 200,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FireStorePostStorage().likePost(widget.snapshot['postId'],
                  userDetails.uid, widget.snapshot['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.width > webscreensize
                        ? MediaQuery.of(context).size.height * 0.5
                        : MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Image(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(
                        widget.snapshot['postUrl'],
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return const Icon(Icons.error);
                      },
                    )),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(milliseconds: 300),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      )),
                )
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snapshot['likes'].contains(userDetails.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FireStorePostStorage().likePost(
                        widget.snapshot['postId'],
                        userDetails.uid,
                        widget.snapshot['likes']);
                  },
                  icon: widget.snapshot['likes'].contains(userDetails.uid)
                      ? const Icon(
                          Icons.favorite,
                          size: 32,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                          size: 32,
                          color: primaryColor,
                        ),
                ),
              ),
              IconButton(
                  onPressed: () => width > webscreensize
                      ? commentDialog(context)
                      : commentBottomSheet(context),
                  // : Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //     return CommentsScreen(snapshot: widget.snapshot);
                  //   })),
                  icon: const Icon(
                    Icons.message_rounded,
                    size: 32,
                    color: primaryColor,
                  )),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/instagram-share-icon (1).svg',
                  height: 25,
                  color: primaryColor,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_outlined,
                    size: 32,
                  ))
            ],
          ),
          //description
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snapshot['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: primaryColor),
                          children: [
                        TextSpan(
                          text: '${widget.snapshot['username']}  ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.snapshot['description'],
                        )
                      ])),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: InkWell(
                      onTap: () => width > webscreensize
                          ? commentDialog(context)
                          : commentBottomSheet(context),

                      //  Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         CommentsScreen(snapshot: widget.snapshot))),
                      child: Text(
                        "view all $commentsLength comments ",
                        style: const TextStyle(
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    // padding: EdgeInsets.symmetric(vertical: ),
                    child: Text(
                  DateFormat.yMMMd()
                      .format(widget.snapshot['datePublished'].toDate()),
                  style: const TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  PersistentBottomSheetController commentBottomSheet(BuildContext context) {
    return showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            maxChildSize: 0.9,
            initialChildSize: 0.6,
            minChildSize: 0.2,
            builder: (context, scrollController) {
              return CommentsScreen(snapshot: widget.snapshot);
            },
          ),
        );
      },
    );
  }

  Future<dynamic> commentDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: Colors.black12,
      context: context,
      builder: (context) => Align(
        alignment: Alignment.bottomRight,
        child: AlertDialog(
            scrollable: true,
            contentPadding: const EdgeInsets.all(0),
            alignment: const Alignment(1, 1),
            content: Container(
              height: 580,
              margin: const EdgeInsets.all(0),
              width: 350,
              child: CommentsScreen(snapshot: widget.snapshot),
            )),
      ),
    );
  }
}
