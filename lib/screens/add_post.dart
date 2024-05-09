import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController discriptionController = TextEditingController();
  Uint8List? pickedImage;

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('select image from'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    pickedImage = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallary'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    pickedImage = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('cancle'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserProvider>(context).getUserDetails;
    print(userDetails.profileUrl);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text("New Post"),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'post',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ))
        ],
      ),
      body: pickedImage == null
          ? Center(
              child: IconButton(
                  onPressed: () {
                    _selectImage(context);
                  },
                  icon: const Icon(Icons.upload_outlined)))
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userDetails.profileUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Caption ", border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(pickedImage!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
    );
  }
}
