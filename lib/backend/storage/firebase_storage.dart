// import "package:flutter/material.dart";
import "dart:typed_data";

import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference storageRef =
        firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = storageRef.putData(file, metadata);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
