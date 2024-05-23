import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReelData {
  final String description;
  final String uid;
  final String username;
  final String reelId;
  final DateTime datePublished;
  final String reelUrl;
  final String profileUrl;
  final likes;
  final String musicName;
  final String taggedUsernames;

  ReelData({
    required this.description,
    required this.uid,
    required this.username,
    required this.reelId,
    required this.datePublished,
    required this.reelUrl,
    required this.likes,
    required this.profileUrl,
    required this.musicName,
    required this.taggedUsernames,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'reelId': reelId,
        'datePublished': datePublished,
        'reelUrl': reelUrl,
        'profileImage': profileUrl,
        'likes': likes,
        'musicName': musicName,
        'taggedUsernames': taggedUsernames,
      };

  static ReelData fromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return ReelData(
      description: snapshot['description'],
      username: snapshot['username'],
      reelId: snapshot['reelId'],
      datePublished: snapshot['datePublished'],
      reelUrl: snapshot['reelUrl'],
      profileUrl: snapshot['profileImage'],
      uid: documentSnapshot["uid"],
      likes: snapshot['likes'],
      musicName: snapshot['musicName'],
      taggedUsernames: snapshot['taggedUsernames'],
    );
  }
}
