import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Username'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      NetworkImage('https://source.unsplash.com/random?sig=1'),
                ),
                const SizedBox(
                    width: 10), // Add spacing between avatar and columns
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customColumn(2, 'Posts'),
                          customColumn(4, 'Followers'),
                          customColumn(3, 'Following'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column customColumn(int value, String labelName) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          labelName,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      ],
    );
  }
}
