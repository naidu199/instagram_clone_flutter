import 'package:flutter/material.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserProvider>(context).getUserDetails;
    print(userDetails.profileUrl);
    return Scaffold(
      body: Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(10),
          child: Image(image: NetworkImage(userDetails.profileUrl))),
    );
  }
}
