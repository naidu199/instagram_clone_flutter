import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/backend/storage/firebase_storage_firestore.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:uuid/uuid.dart';

class FireStorePostStorage {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
      await _firebaseFirestore
          .collection('posts')
          .doc(postId)
          .set(postDetails.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComments(String postId, String commentText, String uid,
      String username, String profileUrl) async {
    try {
      if (commentText.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firebaseFirestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'username': username,
          'profileUrl': profileUrl,
          'commentText': commentText,
          'userId': uid,
          'commentId': commentId,
          'timestamp': DateTime.now()
        });
      } else {
        print('error in comment ');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
