import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController biocontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    biocontroller.dispose();
    usernamecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2024/03/20/06/18/ai-generated-8644732_1280.jpg"),
                    ),
                    Positioned(
                        bottom: -1,
                        right: -10,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 26,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldInput(
                  hintText: 'Username',
                  textEditingController: usernamecontroller,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Email or Phone Number',
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Password',
                  textEditingController: passwordController,
                  isPassword: true,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Enter Bio',
                  textEditingController: biocontroller,
                  isPassword: false,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    child: Text("SignUp"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor,
                    ),
                  ),
                ),

                // Flexible(
                //   child: Container(),
                //   flex: 1,
                // ),

                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Alraedy have an account? "),
                      // padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text(
                          "login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    )
                  ],
                ),
                Spacer(),
                // SizedBox(
                //   height: 10,
                // )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
