import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final TextInputType textInputType;
  final String hintText;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPassword = false,
      required this.textInputType,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
      ),
      obscureText: isPassword,
      keyboardType: textInputType,
    );
  }
}
