import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/backend/storage/firebase_storage.dart';

class AuthSignUp {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<String> signup({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? profilepic,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        //user signup
        UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String profileUrl = await StorageMethods()
            .uploadImageToStorage('profilepic', profilepic!, false);
        //adding user to database
        await firestore.collection('Users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'username': username,
          'email': email,
          'password': password,
          'bio': bio,
          'followers': [],
          'following': [],
          'profileImage': profileUrl,
        });
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else {
        res = e.message.toString();
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
