import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';

class ReelsActionBar extends StatelessWidget {
  const ReelsActionBar({super.key});
  final double iconsize = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            color: primaryColor,
            Icons.favorite_border,
            size: iconsize,
          ),
        ),
        const Text('3.4k',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            )),
        const SizedBox(
          height: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            color: primaryColor,
            Icons.messenger_outline,
            size: iconsize,
          ),
        ),
        const Text(
          '1.4k',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/instagram-share-icon (1).svg',
            height: 25,
            color: primaryColor,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            color: primaryColor,
            Icons.more_vert,
            size: iconsize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(2),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://source.unsplash.com/random?sig=299'))),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
