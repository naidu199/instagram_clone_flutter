import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/3621/3621435.png'),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('UserName',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: ['Delete']
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image(
              image: NetworkImage(
                'https://buffer.com/library/content/images/2023/10/free-images.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  size: 32,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message_rounded,
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
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
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
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '123 likes',
                    style: Theme.of(context).textTheme.bodyText2,
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
                          text: 'username',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' this is the first post ',
                        )
                      ])),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "view 200 comments ",
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                    // padding: EdgeInsets.symmetric(vertical: ),
                    child: Text(
                  "22 april ",
                  style: TextStyle(
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
}
