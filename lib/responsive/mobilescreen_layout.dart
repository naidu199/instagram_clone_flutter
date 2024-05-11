import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/backend/providers/user_providers.dart';
// import 'package:instagram_clone/model/user.dart';
// import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _seletedIndex = 0;
  final List<Widget> pages = [
    FeedScreen(),
    SearchScreen(),
    AddPost(),
    Container(color: Colors.yellow),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // UserDetails userDetails = Provider.of<UserProvider>(context).getUserDetails;
    return Scaffold(
      body: pages[_seletedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _seletedIndex,
        onTap: (index) {
          setState(() {
            _seletedIndex = index;
          });
        },
        backgroundColor: mobileBackgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              backgroundColor: primaryColor,
              label: '',
              icon: Icon(
                _seletedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
                color: _seletedIndex == 0 ? primaryColor : secondaryColor,
                // color: primaryColor,
                size: 32,
              )),
          // BottomNavigationBarItem(
          //     backgroundColor: primaryColor,
          //     label: '',
          //     icon: Icon(
          //       _seletedIndex == 1
          //           ? Icons.search_outlined
          //           : Icons.search_rounded,
          //       color: _seletedIndex == 0 ? primaryColor : secondaryColor,
          //       size: 32,
          //     )),
          BottomNavigationBarItem(
              backgroundColor: primaryColor,
              label: '',
              icon: SvgPicture.asset(
                'assets/search-line-icon.svg',
                color: _seletedIndex == 1 ? primaryColor : secondaryColor,
                height: 32,
                width: 32,
              )),
          BottomNavigationBarItem(
              backgroundColor: primaryColor,
              label: '',
              icon: SvgPicture.asset(
                'assets/add-square-outline.svg', //TODO add box sharp icon
                color: _seletedIndex == 2 ? primaryColor : secondaryColor,
                height: 32,
                width: 32,
              )),
          BottomNavigationBarItem(
              backgroundColor: primaryColor,
              label: '',
              icon: SvgPicture.asset(
                'assets/instagram-reels-icon.svg',
                color: _seletedIndex == 3 ? primaryColor : secondaryColor,
                height: 32,
                width: 32,
              )),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            label: '',
            icon: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: _seletedIndex == 4
                        ? primaryColor
                        : const Color.fromARGB(255, 122, 118, 118),
                  ),
                  color: primaryColor,
                  shape: BoxShape.circle),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/w1.jpg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
