// // import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_side_menu/flutter_side_menu.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:instagram_clone/backend/providers/user_providers.dart';
// import 'package:instagram_clone/model/user.dart';
// import 'package:instagram_clone/screens/add_post.dart';
// import 'package:instagram_clone/screens/feed_screen.dart';
// import 'package:instagram_clone/screens/profile.dart';
// import 'package:instagram_clone/screens/search_screen.dart';
// import 'package:instagram_clone/screens/suggestion_user.dart';
// import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/widgets/post_feed.dart';
// import 'package:provider/provider.dart';

// class WebScreenLayout extends StatefulWidget {
//   const WebScreenLayout({super.key});

//   @override
//   State<WebScreenLayout> createState() => _WebScreenLayoutState();
// }

// class _WebScreenLayoutState extends State<WebScreenLayout> {
//   final SideMenuController _controller = SideMenuController();
//   int _currentIndex = 0;

//   final List<Widget> pages = [
//     const PostFeed(),
//     const SearchScreen(),
//     Container(color: Colors.yellow),
//     Container(
//       color: Colors.purple,
//     ),
//     Container(
//       color: Colors.green,
//     ),
//     const AddPost(),
//     ProfileScreen(
//       uid: FirebaseAuth.instance.currentUser!.uid,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     UserDetails userDetails = Provider.of<UserProvider>(context).getUser;
//     return Scaffold(
//       body: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, left: 10),
//             child: SideMenu(
//               controller: _controller,
//               backgroundColor: mobileBackgroundColor,
//               mode: SideMenuMode.open,
//               builder: (data) {
//                 return SideMenuData(
//                   header: Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: SvgPicture.asset(
//                       'assets/ic_instagram.svg',

//                       // ignore: deprecated_member_use
//                       color: primaryColor,
//                       height: 48,
//                     ),
//                   ),
//                   items: [
//                     // const SideMenuItemDataTitle(title: 'Section Header'),

//                     SideMenuItemDataTile(
//                       // margin: const EdgeInsetsDirectional.only(top: 10),
//                       margin: const EdgeInsetsDirectional.only(top: 20),
//                       isSelected: _currentIndex == 0,
//                       onTap: () => setState(() => _currentIndex = 0),
//                       title: 'Home',
//                       hoverColor: Colors.white38,
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                       icon: const Icon(
//                         Icons.home_outlined,
//                         // size: 32,
//                       ),
//                       selectedIcon: const Icon(Icons.home),
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       // badgeContent: const Text(
//                       //   '23',
//                       //   style: TextStyle(
//                       //     fontSize: 8,
//                       //     color: Colors.white,
//                       //   ),
//                       // ),
//                     ),
//                     SideMenuItemDataTile(
//                       margin: const EdgeInsetsDirectional.only(top: 10),
//                       isSelected: _currentIndex == 1,
//                       onTap: () => setState(() => _currentIndex = 1),
//                       title: 'Search',
//                       hoverColor: Colors.white38,
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       icon: const Icon(
//                         Icons.search_outlined,
//                         color: secondaryColor,
//                       ),
//                       selectedIcon: const Icon(
//                         Icons.search,
//                         color: primaryColor,
//                       ),
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                     ),
//                     SideMenuItemDataTile(
//                       margin: const EdgeInsetsDirectional.only(top: 10),
//                       isSelected: _currentIndex == 2,
//                       onTap: () => setState(() => _currentIndex = 2),
//                       title: 'Reels',
//                       hoverColor: Colors.white38,
//                       itemHeight: 40,
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       icon: Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: SvgPicture.asset(
//                           'assets/instagram-reels-icon.svg',
//                           color: secondaryColor,
//                           // width: 10,
//                           // height: 10,
//                         ),
//                       ),
//                       selectedIcon: Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: SvgPicture.asset(
//                           'assets/instagram-reels-icon.svg',
//                           color: primaryColor,
//                           // width: 10,
//                           // height: 10,
//                         ),
//                       ),
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                     ),
//                     SideMenuItemDataTile(
//                       margin: const EdgeInsetsDirectional.only(top: 10),
//                       isSelected: _currentIndex == 3,
//                       onTap: () => setState(() => _currentIndex = 3),
//                       title: 'Messages',
//                       hoverColor: Colors.white38,
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       icon: const Icon(Icons.chat_bubble_outline),
//                       selectedIcon: const Icon(Icons.chat_bubble),
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                     ),
//                     SideMenuItemDataTile(
//                       margin: const EdgeInsetsDirectional.only(top: 10),
//                       isSelected: _currentIndex == 4,
//                       onTap: () => setState(() => _currentIndex = 4),
//                       title: 'Notifications',
//                       hoverColor: Colors.white38,
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       icon: const Icon(Icons.favorite_border),
//                       selectedIcon: const Icon(Icons.favorite),
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                     ),
//                     SideMenuItemDataTile(
//                       margin: const EdgeInsetsDirectional.only(top: 10),
//                       isSelected: _currentIndex == 5,
//                       onTap: () => setState(() => _currentIndex = 5),
//                       title: 'Create',
//                       hoverColor: Colors.white38,
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       icon: const Icon(Icons.add_box_outlined),
//                       selectedIcon: const Icon(Icons.add_box_sharp),
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                     ),
//                     SideMenuItemDataTile(
//                       margin: const EdgeInsetsDirectional.only(top: 10),
//                       isSelected: _currentIndex == 6,
//                       onTap: () => setState(() => _currentIndex = 6),
//                       title: 'Profile',
//                       hoverColor: Colors.white38,
//                       selectedTitleStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor),
//                       icon: const Icon(Icons.person_2_outlined),
//                       selectedIcon: const Icon(Icons.person_2),
//                       titleStyle:
//                           const TextStyle(color: secondaryColor, fontSize: 18),
//                     ),
//                   ],
//                   footer: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(userDetails.profileUrl),
//                     ),
//                     title: Text(userDetails.username),
//                     subtitle: Text(userDetails.bio),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: mobileBackgroundColor,
//               child: pages[_currentIndex],
//             ),
//           ),
//           SideMenu(
//             maxWidth: 380,
//             position: SideMenuPosition.right,
//             builder: (data) => const SideMenuData(
//               customChild: SuggestionScreen(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
