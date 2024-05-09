import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/backend/storage/firebase_storage_firestore.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:uuid/uuid.dart';

class FireStorePostStorage {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profileUrl) async {
    String res = "some error in storage";
    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      PostDetails postDetails = PostDetails(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: postUrl,
          likes: [],
          profileUrl: profileUrl);
      await firebaseFirestore
          .collection('posts')
          .doc(postId)
          .set(postDetails.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
