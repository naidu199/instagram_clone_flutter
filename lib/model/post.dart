import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetails {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profileUrl;
  final likes;

  PostDetails(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.likes,
      required this.profileUrl});

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profileImage': profileUrl,
        'likes': likes
      };

  static PostDetails fromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return PostDetails(
        description: snapshot['description'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['postUrl'],
        profileUrl: snapshot['profileImage'],
        uid: documentSnapshot["uid"],
        likes: snapshot['likes']);
  }
}
