import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final Widget child;
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChange;

  CommonTextField(
      {super.key,
      this.onChange,
      required this.controller,
      required this.child,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w300,
          color: Colors.black.withOpacity(0.3),
          fontFamily: "sfPro"),
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value) ?? () {};
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 20),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.3),
            fontSize: 17,
            height: 2,
            fontWeight: FontWeight.w200),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15),
          child: child,
        ),
      ),
    );
  }
}
