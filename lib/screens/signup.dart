import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/backend/authentication/auth_signup.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
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
  Uint8List? profileImage;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    biocontroller.dispose();
    usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  // color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    profileImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(profileImage!),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg"),
                          ),
                    Positioned(
                        bottom: -1,
                        right: -10,
                        child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 26,
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldInput(
                  hintText: 'Username',
                  textEditingController: usernamecontroller,
                  textInputType: TextInputType.text,
                  isPassword: false,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Email or Phone Number',
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Password',
                  textEditingController: passwordController,
                  isPassword: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Enter Bio',
                  textEditingController: biocontroller,
                  isPassword: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    String res = await AuthSignUp().signup(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        username: usernamecontroller.text.trim(),
                        bio: biocontroller.text.trim(),
                        profilepic: profileImage);
                    print(res);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor,
                    ),
                    child: const Text("SignUp"),
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Alraedy have an account? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const Spacer(),
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
