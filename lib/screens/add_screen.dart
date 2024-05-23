import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_mobile.dart';
import 'package:instagram_clone/screens/add_reel.dart';
import 'package:instagram_clone/utils/colors.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      currentIndex = page;
    });
  }

  onNavigation(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                AddPostMobile(),
                AddReel(),
              ],
            ),
            AnimatedPositioned(
              bottom: 10,
              right: currentIndex == 0 ? 100 : 150,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onNavigation(0);
                      },
                      child: Text(
                        'post',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color:
                              currentIndex == 0 ? Colors.blue : secondaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onNavigation(1);
                      },
                      child: Text(
                        'Reel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color:
                              currentIndex == 1 ? Colors.blue : secondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
