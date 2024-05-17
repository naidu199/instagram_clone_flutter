// import 'dart:js';

// import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:instagram_clone/screens/home_page.dart';
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/screens/signup.dart';

class AppRoutes {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homePageRoute = '/home_page';
  static final routes = {
    loginRoute: (context) => const LoginScreen(),
    signupRoute: (context) => const SignUpScreen(),
    homePageRoute: (context) => const HomePage(),
  };
}
