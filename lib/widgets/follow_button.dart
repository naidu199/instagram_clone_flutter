import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backGroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const FollowButton(
      {super.key,
      this.function,
      required this.backGroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 28,
      padding: const EdgeInsets.only(top: 28),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
              color: backGroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
