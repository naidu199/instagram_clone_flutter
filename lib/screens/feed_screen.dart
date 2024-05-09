import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: 32,
              )),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/instagram-share-icon (1).svg',
              height: 25,
              // width: 30,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: PostCard(),
    );
  }
}
