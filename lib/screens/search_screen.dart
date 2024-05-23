import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/screens/post_view.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_consts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isUsers = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: isUsers
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isUsers = !isUsers;
                    _searchController.text = "";
                  });
                },
                icon: const Icon(Icons.arrow_back))
            : null,
        automaticallyImplyLeading: true,
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(5)),
            // ),
            // icon: Icon(Icons.search),
            labelText: 'search',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isUsers = true;
            });
          },
        ),
      ),
      body: isUsers
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<DocumentSnapshot<Map<String, dynamic>>> users =
                    snapshot.data!.docs;
                // print(users);

                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final userData = users[index].data()!;

                      return InkWell(
                        onTap: () => width > webscreensize
                            ? showBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: DraggableScrollableSheet(
                                      maxChildSize: 1,
                                      initialChildSize: 1,
                                      minChildSize: 0.2,
                                      builder: (context, scrollController) {
                                        return ProfileScreen(
                                            uid: userData['uid']);
                                      },
                                    ),
                                  );
                                },
                              )
                            : Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileScreen(uid: userData['uid']),
                                ),
                              ),
                        child: ListTile(
                          key: UniqueKey(),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userData['profileImage']),
                          ),
                          title: Text(userData['username']),
                        ),
                      );
                    });
              })
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<DocumentSnapshot<Map<String, dynamic>>> posts =
                    snapshot.data!.docs;
                return MasonryGridView.builder(
                  itemCount: posts.length,
                  // itemCount: 100,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final post = posts[index].data();
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          width > webscreensize
                              ? showBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: DraggableScrollableSheet(
                                        maxChildSize: 1,
                                        initialChildSize: 1,
                                        minChildSize: 0.2,
                                        builder: (context, scrollController) {
                                          return PostView(snapshot: post);
                                        },
                                      ),
                                    );
                                  },
                                )
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PostView(snapshot: post)));
                        },
                        child: Image(
                          image: NetworkImage(post!['postUrl']),
                        ),
                      ),
                      //   image: NetworkImage(
                      //       'https://source.unsplash.com/random?sig=$index'),
                      // ),
                    );
                  },
                );
              }),
    );
  }
}
