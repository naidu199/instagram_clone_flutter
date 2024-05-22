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
              'username',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ExpandableText(
              'description of the reel ah,u 2,ijoejvv vvvvv  oiifjv oiffoo uvlivj  ihiu2hlijolg vhui hiuh4hliv3wgy33hhgo8yoh3fjflhh uhlgn3yi23tu98lhihggjoiwjugru2y  ug2uyfglhtofluyo87y',
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
            leading: Icon(
              Icons.graphic_eq_outlined,
              size: 16,
              color: primaryColor,
            ),
            title: Row(
              children: [
                Container(
                  height: 20,
                  width: 150,
                  child: Marquee(
                    scrollAxis: Axis.horizontal,
                    velocity: 10,
                    text: 'music -- name',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.person_outline_outlined,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
                const Text(
                  'user name',
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
