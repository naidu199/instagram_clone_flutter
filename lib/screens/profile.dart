import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/backend/storage/firestore_methods.dart';
// import 'package:instagram_clone/model/user.dart';
// import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/utils/snackbars.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
// import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var userData = {};
  Uint8List? profileImage;
  bool isloading = false;
  int noOfPosts = 0;
  int noOfFollowers = 0;
  int noOfFollowing = 0;
  bool isFollowing = false;
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    user = FirebaseAuth.instance.currentUser!;
    try {
      setState(() {
        isloading = true;
      });
      var usersnap = await firestore.collection('Users').doc(widget.uid).get();
      var postsnap = await firestore
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      noOfPosts = postsnap.docs.length;
      userData = usersnap.data()!;
      noOfFollowers = usersnap.data()!['followers'].length;
      noOfFollowing = usersnap.data()!['following'].length;
      isFollowing = usersnap.data()!['followers'].contains(widget.uid);
      setState(() {
        isloading = false;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username'] ?? "username"),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
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
                                      backgroundImage:
                                          MemoryImage(profileImage!),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(userData[
                                              'profileImage'] ??
                                          "https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg"),
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
                              width:
                                  10), // Add spacing between avatar and columns
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    customColumn(noOfPosts, 'Posts'),
                                    customColumn(noOfFollowers, 'Followers'),
                                    customColumn(noOfFollowing, 'Following'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(userData['username'] ?? "username"),
                      Text(userData['bio'] != "" ? userData['bio'] : "bio"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          user!.uid == widget.uid
                              ? CustomButton(
                                  function: () {},
                                  text: 'Edit',
                                  backgroundcolor: mobileBackgroundColor,
                                  textColor: primaryColor)
                              : isFollowing
                                  ? CustomButton(
                                      function: () async {
                                        await FireStoreMethods()
                                            .followUser(user!.uid, widget.uid);

                                        setState(() {
                                          isFollowing = false;
                                          noOfFollowers--;
                                        });
                                      },
                                      text: 'following',
                                      backgroundcolor: Colors.white,
                                      textColor: Colors.black)
                                  : CustomButton(
                                      function: () async {
                                        await FireStoreMethods()
                                            .followUser(user!.uid, widget.uid);
                                        setState(() {
                                          isFollowing = true;
                                          noOfFollowers++;
                                        });
                                      },
                                      text: 'follow',
                                      backgroundcolor: Colors.blue,
                                      textColor: primaryColor),
                          CustomButton(
                              function: () {},
                              text: 'share',
                              backgroundcolor: mobileBackgroundColor,
                              textColor: primaryColor),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: firestore
                              .collection('posts')
                              .where('uid', isEqualTo: widget.uid)
                              .get(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 3,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: ((context, index) {
                                  var snap = snapshot.data!.docs[index].data();

                                  return Container(
                                    child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snap['postUrl'])),
                                  );
                                }));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
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
