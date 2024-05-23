import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/post_feed.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        body: const PostFeed(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            floating: true,
            leading: const Icon(
              Icons.camera_alt_outlined,
              size: 32,
              color: primaryColor,
            ),
            backgroundColor: mobileBackgroundColor,
            centerTitle: true,
            title: SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 32,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
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
        ],
      ),
    );
  }
}
