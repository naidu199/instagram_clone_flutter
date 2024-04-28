import 'package:firebase_auth/firebase_auth.dart';

class AuthLogin {
  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "Some error has occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = "please enter all the fields ";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        res = 'Invalid Password ';
      } else if (e.message.toString() ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        res = "Invalid credential";
      } else {
        res = e.message.toString();
        print(res);
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
