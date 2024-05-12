import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/model/user.dart';
// import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? profileImage;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, _) {
      UserDetails userDetails = value.getUser;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      profileImage != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(profileImage!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userDetails.profileUrl),
                            ),
                      Positioned(
                          bottom: -1,
                          right: -10,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 20,
                            ),
                          ))
                    ],
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
              Text("Username"),
              Text('Bio'),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      text: 'Edit Profile',
                      backgroundcolor: mobileBackgroundColor,
                      textColor: primaryColor),
                  CustomButton(
                      text: 'Share Profile',
                      backgroundcolor: mobileBackgroundColor,
                      textColor: primaryColor),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Column customColumn(int value, String labelName) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3),
        Text(
          labelName,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      ],
    );
  }
}
