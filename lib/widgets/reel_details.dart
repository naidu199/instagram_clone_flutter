import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:marquee/marquee.dart';

class ReelDetails extends StatelessWidget {
  const ReelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            dense: true,
            minLeadingWidth: 0,
            horizontalTitleGap: 12,
            leading: CircleAvatar(
              radius: 14,
              backgroundImage:
                  NetworkImage('https://source.unsplash.com/random?sig=299'),
            ),
            title: Text(
              'naidu199',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ExpandableText(
              "Another cool reel!, Don't miss this reel! Get ready for jaw-dropping moments, endless entertainment, and a rollercoaster of emotions. Hit play and let the fun begin!",
              expandText: 'more..',
              collapseText: 'less',
              expandOnTextTap: true,
              collapseOnTextTap: true,
              maxLines: 2,
              linkColor: secondaryColor,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            dense: true,
            minLeadingWidth: 0,
            horizontalTitleGap: 6,
            leading: const Icon(
              Icons.graphic_eq_outlined,
              size: 16,
              color: primaryColor,
            ),
            title: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 150,
                  child: Marquee(
                    scrollAxis: Axis.horizontal,
                    velocity: 10,
                    text: 'Awesome Beats--Great Tune',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.person_outline_outlined,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
                const Text(
                  'vishnu587',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
