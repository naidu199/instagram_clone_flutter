import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/screens/signup.dart';

class AppRoutes {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  // static const String homePageRoute = '/homepage';
  static final routes = {
    loginRoute: (context) => const LoginScreen(),
    signupRoute: (context) => const SignUpScreen(),
    // homePageRoute: (context) => const HomePage(),
  };
}
