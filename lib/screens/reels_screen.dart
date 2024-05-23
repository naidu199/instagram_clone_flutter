import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/model/reel.dart';
// import 'package:instagram_clone/model/reel.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_consts.dart';
import 'package:instagram_clone/widgets/reel_details.dart';
import 'package:instagram_clone/widgets/reels_action_bar.dart';
import 'package:instagram_clone/widgets/video_player.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Reels',
          style: TextStyle(
              color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 32,
                color: primaryColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: dummyReels.length,
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  width: width > webscreensize ? 400 : width,
                  decoration: BoxDecoration(
                      border: Border.all(color: mobileBackgroundColor),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                              'https://source.unsplash.com/random?sig=$index'))),
                  child: const Center(
                    child: Stack(
                      children: [
                        // VideoPlayerWidget(url: 'url'),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Colors.black.withOpacity(0.2),
                        //         Colors.transparent
                        //       ],
                        //       begin: const Alignment(0, -0.75),
                        //       end: const Alignment(0, 0.1),
                        //     ),
                        //   ),
                        // ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  flex: 12,
                                  child: ReelDetails(
                                      // reel: dummyReels[index],
                                      ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: ReelsActionBar(
                                      // reel: dummyReels[index],
                                      ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  List<ReelData> dummyReels = [
    ReelData(
      description:
          "Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user123",
      username: "naidu1909",
      reelId: "reel001",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel1.mp4",
      profileUrl: "https://example.com/profiles/testuser1.jpg",
      likes: 120,
      musicName: "Cool Music",
      taggedUsernames: "naidu199",
    ),
    ReelData(
      description:
          "Another cool reel!, Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user124",
      username: "naidu2004",
      reelId: "reel002",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel2.mp4",
      profileUrl: "https://example.com/profiles/testuser2.jpg",
      likes: 85,
      musicName: "Awesome Beats",
      taggedUsernames: "vishnu578",
    ),
    ReelData(
      description:
          "Don't miss this reel! Experience unforgettable highlights, laugh-out-loud clips, and captivating scenes. Click play and dive into the excitement!",
      uid: "user125",
      username: "vishnu578",
      reelId: "reel003",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel3.mp4",
      profileUrl: "https://example.com/profiles/testuser3.jpg",
      likes: 200,
      musicName: "Great Tune",
      taggedUsernames: "naidu1909",
    ),
    ReelData(
      description:
          "Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user123",
      username: "naidu1909",
      reelId: "reel001",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel1.mp4",
      profileUrl: "https://example.com/profiles/testuser1.jpg",
      likes: 120,
      musicName: "Cool Music",
      taggedUsernames: "naidu199",
    ),
    ReelData(
      description:
          "Another cool reel!, Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user124",
      username: "naidu2004",
      reelId: "reel002",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel2.mp4",
      profileUrl: "https://example.com/profiles/testuser2.jpg",
      likes: 85,
      musicName: "Awesome Beats",
      taggedUsernames: "vishnu578",
    ),
    ReelData(
      description:
          "Don't miss this reel! Experience unforgettable highlights, laugh-out-loud clips, and captivating scenes. Click play and dive into the excitement!",
      uid: "user125",
      username: "vishnu578",
      reelId: "reel003",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel3.mp4",
      profileUrl: "https://example.com/profiles/testuser3.jpg",
      likes: 200,
      musicName: "Great Tune",
      taggedUsernames: "naidu1909",
    ),
    ReelData(
      description:
          "Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user123",
      username: "naidu1909",
      reelId: "reel001",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel1.mp4",
      profileUrl: "https://example.com/profiles/testuser1.jpg",
      likes: 120,
      musicName: "Cool Music",
      taggedUsernames: "naidu199",
    ),
    ReelData(
      description:
          "Another cool reel!, Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user124",
      username: "naidu2004",
      reelId: "reel002",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel2.mp4",
      profileUrl: "https://example.com/profiles/testuser2.jpg",
      likes: 85,
      musicName: "Awesome Beats",
      taggedUsernames: "vishnu578",
    ),
    ReelData(
      description:
          "Don't miss this reel! Experience unforgettable highlights, laugh-out-loud clips, and captivating scenes. Click play and dive into the excitement!",
      uid: "user125",
      username: "vishnu578",
      reelId: "reel003",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel3.mp4",
      profileUrl: "https://example.com/profiles/testuser3.jpg",
      likes: 200,
      musicName: "Great Tune",
      taggedUsernames: "naidu1909",
    ),
    ReelData(
      description:
          "Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user123",
      username: "naidu1909",
      reelId: "reel001",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel1.mp4",
      profileUrl: "https://example.com/profiles/testuser1.jpg",
      likes: 120,
      musicName: "Cool Music",
      taggedUsernames: "naidu199",
    ),
    ReelData(
      description:
          "Another cool reel!, Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
      uid: "user124",
      username: "naidu2004",
      reelId: "reel002",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel2.mp4",
      profileUrl: "https://example.com/profiles/testuser2.jpg",
      likes: 85,
      musicName: "Awesome Beats",
      taggedUsernames: "vishnu578",
    ),
    ReelData(
      description:
          "Don't miss this reel! Experience unforgettable highlights, laugh-out-loud clips, and captivating scenes. Click play and dive into the excitement!",
      uid: "user125",
      username: "vishnu578",
      reelId: "reel003",
      datePublished: DateTime.now(),
      reelUrl: "https://example.com/reels/reel3.mp4",
      profileUrl: "https://example.com/profiles/testuser3.jpg",
      likes: 200,
      musicName: "Great Tune",
      taggedUsernames: "naidu1909",
    ),
  ];
}
