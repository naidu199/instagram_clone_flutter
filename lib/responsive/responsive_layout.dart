import 'package:flutter/material.dart';
import 'package:instagram_clone/backend/providers/user_providers.dart';
import 'package:instagram_clone/utils/global_consts.dart';
import 'package:instagram_clone/widgets/gradient.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    userData();
  }

  userData() async {
    setState(() {
      isloading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUserDetails();
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return isloading
        ? Scaffold(
            body: Center(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Container(
                    height: width > webscreensize ? 60 : 30,
                    width: width > webscreensize ? 60 : 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/insta_logo.png')),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(
                    'from',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const GradientText(
                    'naidu199 ',
                    style: TextStyle(fontSize: 20),
                    gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // display web screen layout
                return widget.webScreenLayout;
              } else {
                // display  mobile screen layout
                return widget.mobileScreenLayout;
              }
            },
          );
  }
}
