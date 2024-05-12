import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundcolor;
  final Color textColor;
  const CustomButton(
      {super.key,
      required this.text,
      required this.backgroundcolor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        width: 200,
        height: 35,
        decoration: BoxDecoration(
            color: backgroundcolor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: textColor, width: 1)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                backgroundColor: backgroundcolor,
                color: textColor,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
