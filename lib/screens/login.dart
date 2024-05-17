import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/backend/authentication/auth_login.dart';
import 'package:instagram_clone/responsive/mobilescreen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';
import 'package:instagram_clone/routes/approutes.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_consts.dart';
import 'package:instagram_clone/utils/snackbars.dart';
import 'package:instagram_clone/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String response = await AuthLogin().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    if (response != "success") {
      // print(response);
      showSnackBar(context, response);
    }

    setState(() {
      _isloading = false;
    });
    if (response == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webscreensize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              // ignore: deprecated_member_use
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldInput(
              hintText: 'Email or Phone Number',
              textEditingController: emailController,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Password',
              textEditingController: passwordController,
              isPassword: true,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor,
                ),
                child: _isloading
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primaryColor,
                        ),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Flexible(
            //   flex: 1,
            //   child: Container(),
            // ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text(
                    "Don't have an account?  ",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.signupRoute);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text(
                      "signup",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: primaryColor),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
          ],
        ),
      )),
    );
  }
}
