import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/backend/storage/firestore_methods.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    UserDetails currentUser = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Suggested for you'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('uid', isNotEqualTo: currentUser.uid)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Refresh"),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> userDetails =
                            snapshot.data!.docs[index].data();
                        bool isFollowing =
                            userDetails['followers'].contains(currentUser.uid);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userDetails['profileImage']),
                          ),
                          title: Text(userDetails['username'] ?? ''),
                          subtitle: Text(userDetails['bio']),
                          trailing: isFollowing
                              ? CustomButton(
                                  function: () async {
                                    await FireStoreMethods().followUser(
                                        currentUser.uid, userDetails['uid']);

                                    setState(() {
                                      isFollowing = false;
                                    });
                                  },
                                  text: 'following',
                                  backgroundcolor: Colors.white,
                                  textColor: Colors.black,
                                  width: 80,
                                )
                              : CustomButton(
                                  function: () async {
                                    await FireStoreMethods().followUser(
                                        currentUser.uid, userDetails['uid']);
                                    setState(() {
                                      isFollowing = true;
                                    });
                                  },
                                  width: 80,
                                  text: 'follow',
                                  backgroundcolor: Colors.blue,
                                  textColor: primaryColor),
                        );
                      });
                })),
          ),
        ],
      ),
    );
  }
}
